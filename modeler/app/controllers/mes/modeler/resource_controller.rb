class Mes::Modeler::ResourceController < Mes::Modeler::BaseController
  include Mes::Modeler::Callbacks

  helper_method :new_object_url, :edit_object_url, :object_url, :collection_url
  before_action :load_resource, except: :update_positions
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  def index
  end

  def show
  end

  def new
    invoke_callbacks(:new_action, :before)
    respond_to do |format|
      format.html { render layout: !request.xhr? }
      format.js   { render layout: false } if request.xhr?
    end
  end

  def edit
    respond_to do |format|
      format.html { render layout: !request.xhr? }
      format.js   { render layout: false } if request.xhr?
    end
  end

  def create
    invoke_callbacks(:create, :before)
    @object.attributes = permitted_resource_params
    if @object.save
      invoke_callbacks(:create, :after)
      flash[:success] = flash_message_for(@object, :successfully_created)
      respond_to do |format|
        format.html { redirect_to location_after_save }
        format.js   { render layout: false }
      end
    else
      invoke_callbacks(:create, :fails)
      respond_to do |format|
        format.html do
          flash.now[:error] = @object.errors.full_messages.join(', ')
          render action: 'new'
        end
        format.js { render layout: false }
      end
    end
  end

  def update
    invoke_callbacks(:update, :before)
    if @object.update_attributes(permitted_resource_params)
      invoke_callbacks(:update, :after)
      flash[:success] = flash_message_for(@object, :successfully_updated)
      respond_to do |format|
        format.html { redirect_to location_after_save }
        format.js { render layout: false }
      end
    else
      invoke_callbacks(:update, :fails)
      respond_to do |format|
        format.html do
          flash.now[:error] = @object.errors.full_messages.join(', ')
          render action: 'edit'
        end
        format.js { render layout: false }
      end
    end
  end

  def update_positions
    ActiveRecord::Base.transaction do
      params[:positions].each do |id, index|
        model_class.find(id).set_list_position(index)
      end
    end

    respond_to do |format|
      format.js { render text: 'Ok' }
    end
  end

  def destroy
    invoke_callbacks(:destroy, :before)
    if @object.destroy
      invoke_callbacks(:destroy, :after)
      flash[:success] = flash_message_for(@object, :successfully_removed)
      respond_to do |format|
        format.html { redirect_to location_after_destroy }
        format.js   { render partial: 'mes/modeler/shared/destroy' }
      end
    else
      invoke_callbacks(:destroy, :fails)
      respond_to do |format|
        format.html { redirect_to location_after_destroy }
      end
    end
  end

  protected

  class << self
    attr_accessor :parent_data

    def belongs_to(model_name, options = {})
      @parent_data ||= {}
      @parent_data[:model_name] = model_name
      @parent_data[:model_class] = model_name.to_s.classify.constantize
      @parent_data[:find_by] = options[:find_by] || :id
    end
  end

  def model_class
    @model_class ||= resource.model_class
  end

  def resource_not_found
    flash[:error] = flash_message_for(model_class.new, :not_found)
    redirect_to collection_url
  end

  def resource
    return @resource if @resource
    parent_model_name = parent_data[:model_name] if parent_data
    @resource = Mes::Modeler::Resource.new controller_path, controller_name, parent_model_name, object_name
  end

  def load_resource
    if member_action?
      @object ||= load_resource_instance

      # Using pundit policy to control action
      authorize @object, "#{action}?"

      instance_variable_set("@#{resource.object_name}", @object)
    else
      @collection ||= collection

      instance_variable_set("@#{controller_name}", @collection)
      authorize @collection.first, 'index?' if @collection.first
    end
  end

  def load_resource_instance
    if new_actions.include?(action)
      build_resource
    elsif params[:id]
      find_resource
    end
  end

  def parent_data
    self.class.parent_data
  end

  def parent
    return nil unless parent_data.present?
    @parent ||= parent_data[:model_class]
                .send("find_by_#{parent_data[:find_by]}", params["#{resource.model_name}_id"])
    instance_variable_set("@#{resource.model_name}", @parent)
  end

  def find_resource
    if parent_data.present?
      parent.send(controller_name).find(params[:id])
    else
      model_class.find(params[:id])
    end
  end

  def build_resource
    if parent_data.present?
      parent.send(controller_name).build
    else
      model_class.new
    end
  end

  def collection
    return parent.send(controller_name) if parent_data.present?
    policy_scope(model_class).where(nil)
  end

  def location_after_destroy
    collection_url
  end

  def location_after_save
    collection_url
  end

  # URL helpers

  def new_object_url(options = {})
    if parent_data.present?
      modeler.new_polymorphic_url([:modeler, parent, model_class], options)
    else
      modeler.new_polymorphic_url([:modeler, model_class], options)
    end
  end

  def edit_object_url(object, options = {})
    if parent_data.present?
      modeler.send "edit_modeler_#{resource.model_name}_#{resource.object_name}_url",
                 parent, object, options
    else
      modeler.send "edit_modeler_#{resource.object_name}_url", object, options
    end
  end

  def object_url(object = nil, options = {})
    target = object ? object : @object
    if parent_data.present?
      modeler.send "modeler_#{resource.model_name}_#{resource.object_name}_url", parent, target, options
    else
      modeler.send "modeler_#{resource.object_name}_url", target, options
    end
  end

  def collection_url(options = {})
    if parent_data.present?
      modeler.polymorphic_url([:modeler, parent, model_class], options)
    else
      modeler.polymorphic_url([:modeler, model_class], options)
    end
  end

  # This method should be overridden when object_name does not match the controller name
  def object_name
  end

  # Allow all attributes to be updatable.
  #
  # Other controllers can, should, override it to set custom logic
  def permitted_resource_params
    params[resource.object_name].present? ? params.require(resource.object_name).permit! : ActionController::Parameters.new
  end

  def collection_actions
    [:index]
  end

  def member_action?
    !collection_actions.include? action
  end

  def new_actions
    [:new, :create]
  end
end
