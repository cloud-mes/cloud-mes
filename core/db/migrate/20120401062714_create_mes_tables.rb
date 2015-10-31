# Make sure all name <= 30 char to support Oracle DB
class CreateMesTables < ActiveRecord::Migration
  def change
    create_table :mes_factories do |t|
      t.string :factory_code, null: false
      t.string :factory_name
      t.string :factory_location

      t.timestamps null: false
    end

    add_index :mes_factories, [:factory_code], name: 'idx_on_factories', unique: true

    create_table :mes_lot_types do |t|
      t.string :name, null: false
      t.string :description, limit: 2000
      t.boolean :active, default: true

      t.timestamps null: false
    end

    create_table :mes_order_types do |t|
      t.string :name, null: false
      t.string :description, limit: 2000
      t.boolean :active, default: true

      t.timestamps null: false
    end

    create_table :mes_hold_reasons do |t|
      t.string :name, null: false
      t.string :description, limit: 2000
      t.boolean :active, default: true

      t.timestamps null: false
    end

    create_table :mes_release_reasons do |t|
      t.string :name, null: false
      t.string :description, limit: 2000
      t.boolean :active, default: true

      t.timestamps null: false
    end

    create_table :mes_products do |t|
      t.string  :product_code, null: false
      t.string  :description, limit: 2000
      t.string  :capacity
      t.string  :customer_code
      t.string  :customer_product_number
      t.string  :customer_eng_rev
      t.string  :customer_product_description
      t.string  :customer_serial_number
      t.string  :wafer_size
      t.string  :leads
      t.string  :form_factor
      t.string  :nand_vendor
      t.string  :nand_type
      t.string  :product_machine_category
      t.string  :product_tool_category
      t.string  :product_component_category
      t.boolean :need_serial_label
      t.string  :internal_serial_number
      t.string  :external_ww_number
      t.integer :quantity_per_box
      t.string  :panel_size
      t.integer :panel_quantity
      t.integer :tray_quantity_length
      t.integer :tray_quantity_width
      t.integer :tray_quantity

      t.timestamps
    end

    add_index :mes_products, [:product_code], name: 'idx_product_code_on_products', unique: true

    create_table :mes_order_type_settings do |t|
      # select field
      t.string  :order_type, null: false
      t.integer :product_id
      # actural configure field
      t.integer :max_allowed_defect

      t.timestamps
    end

    add_index :mes_order_type_settings, [:order_type, :product_id], name: 'idx_wo_type_pt_on_wo_type_sets'

    create_table :mes_low_yield_settings do |t|
      # select field
      t.integer :step_code_id, null: false
      t.string  :order_type
      t.integer :product_id
      # actural configure field
      t.float   :lower_limit
      t.float   :upper_limit
      # if unit failed at unit passed in one work order < threshold_in_pass_number, will ignore and won't trigger low yield
      t.integer :threshold_in_pass_number
      t.string  :notification_email_group

      t.timestamps
    end

    add_index :mes_low_yield_settings, [:order_type, :product_id], name: 'idx_wo_t_pt_on_low_yield_sets'

    create_table :mes_step_codes do |t|
      t.string  :name
      t.string  :description, limit: 2000
      t.integer :step_type
      t.text    :notes
      t.boolean :for_inline_rework
      t.boolean :tray_generation, default: false
      t.boolean :tray_management, default: false
      t.boolean :machine_required, default: false
      t.boolean :can_auto_start_current_step, default: false

      t.timestamps
    end

    create_table :mes_certifications do |t|
      t.string  :name, null: false
      t.string  :description, limit: 2000
      t.integer :life_seconds

      t.timestamps
    end

    add_index :mes_certifications, :name, name: 'idx_cert_code_on_certs'

    create_join_table :step_codes, :certifications, table_name: 'mes_certifications_step_codes' do |t|
      t.index [:step_code_id, :certification_id], unique: true, name: 'idx_step_code_certs'

      t.timestamps
    end

    create_table :mes_operator_certifications do |t|
      t.integer  :user_id, null: false
      t.integer  :certification_id, null: false
      t.datetime :validation_start
      t.datetime :validation_expire

      t.timestamps
    end

    if table_exists? :users
      add_column :users, :step_code_id, :integer
      add_column :users, :shift,        :string
      add_column :users, :admin,        :boolean
      add_column :users, :qa,           :boolean
    end

    add_index :mes_operator_certifications, [:user_id, :certification_id], name: 'idx_on_operator_certifications'

    create_table :mes_step_process_settings do |t|
      # select field
      t.integer :step_code_id, null: false
      t.string  :order_type
      t.integer :product_id
      # actural configure field
      t.integer :same_unit_max_defect_allowed
      t.integer :future_rework_step_code_id
      t.boolean :req_first_article_inspection # checked at move, hold if require
      t.integer :unit_sample_percent

      t.timestamps
    end

    add_index :mes_step_process_settings, [:step_code_id, :order_type, :product_id], name: 'idx_on_step_process_settings', unique: true

    create_table :mes_step_process_defects do |t|
      # select field
      t.integer :step_code_id, null: false
      t.string  :order_type
      t.integer :product_id

      t.timestamps
    end

    add_index :mes_step_process_defects, [:step_code_id, :order_type, :product_id], name: 'idx_on_step_process_defects', unique: true

    create_table :mes_step_process_defect_codes do |t|
      t.integer :step_process_defect_id, null: false
      t.string  :defect_code
    end

    add_index :mes_step_process_defect_codes, [:step_process_defect_id], name: 'idx_on_step_pcs_defect_codes'

    create_table :mes_reject_codes, id: false, primary_key: 'reject_code' do |t|
      t.string :reject_code, null: false
      t.string :reject_type
      t.string :sap_location
    end

    add_index :mes_reject_codes, [:reject_code], name: 'idx_on_reject_codes', unique: true

    create_table :mes_step_process_rejects do |t|
      # select field
      t.integer :step_code_id, null: false
      t.string  :order_type
      t.integer :product_id

      t.timestamps
    end

    add_index :mes_step_process_rejects, [:step_code_id, :order_type, :product_id], name: 'idx_on_step_process_rejects', unique: true

    create_table :mes_step_process_reject_codes do |t|
      t.integer :step_process_reject_id, null: false
      t.string  :reject_code
    end

    add_index :mes_step_process_reject_codes, [:step_process_reject_id], name: 'idx_on_step_pcs_reject_codes'

    create_table :mes_bin_codes, id: false, primary_key: 'bin_code' do |t|
      t.string  :bin_code, null: false
      t.integer :bin_type
      t.string  :description, limit: 2000
    end

    add_index :mes_bin_codes, [:bin_code], name: 'idx_on_bin_codes', unique: true

    create_table :mes_step_process_bins do |t|
      # select field
      t.integer :step_code_id, null: false
      t.string  :order_type
      t.integer :product_id

      t.timestamps
    end

    add_index :mes_step_process_bins, [:step_code_id, :order_type, :product_id], name: 'idx_on_step_process_bins', unique: true

    create_table :mes_step_process_bin_codes do |t|
      t.integer :step_process_bin_id, null: false
      t.string :bin_code
    end

    add_index :mes_step_process_bin_codes, [:step_process_bin_id], name: 'idx_on_step_pcs_bin_codes'

    create_table :mes_inline_rework_next_steps do |t|
      # select field
      t.integer :step_code_id, null: false
      t.string :defect_code, null: false
      t.string :order_type
      t.integer :product_id
      # actural configure field
      t.integer :from_step_code_id, null: false
      t.string :step_result, null: false
      t.integer :to_step_code_id

      t.timestamps
    end

    add_index :mes_inline_rework_next_steps, [:step_code_id, :defect_code, :from_step_code_id], name: 'idx_irns_on_step_defect_codes'

    # Direct Materials / Indirect Materials are all components
    create_table :mes_components do |t|
      t.string   :component_code, null: false
      t.string   :description, limit: 2000
      t.string   :component_type
      t.boolean  :direct_material
      t.integer  :floor_life_seconds
      t.integer  :shelf_life_seconds
      t.integer  :quantity_per_container
      t.string   :container_uom
      t.boolean  :used_at_frontend
      t.boolean  :used_at_backend
      t.boolean  :is_containerized
      t.boolean  :is_active
      t.string   :sap_material_document
      t.datetime :sap_material_doc_time
      t.string   :sap_material_doc_item

      t.timestamps
    end

    add_index :mes_components, [:component_code], name: 'idx_comp_code_on_components', unique: true

    create_table :mes_component_containers do |t|
      t.string   :container_code, null: false
      t.integer  :component_id, null: false
      t.string   :sap_batch
      t.string   :vendor
      t.string   :vendor_lot
      t.string   :vendor_datecode
      t.string   :vendor_part_number
      t.datetime :shelf_life_start
      t.datetime :shelf_life_expire
      t.datetime :floor_life_start
      t.datetime :floor_life_expire
      t.integer  :qty
      t.string   :uom

      t.timestamps
    end

    add_index :mes_component_containers, [:container_code], name: 'idx_co_code_on_comp_containers'
    add_index :mes_component_containers, [:component_id], name: 'idx_comp_id_on_comp_containers'

    create_table :mes_component_step_usage_setup do |t|
      # select field
      t.integer :step_code_id, null: false
      t.string  :product_componenet_category
      t.date    :from_date, null: false
      t.date    :to_date
      # actural configure field
      t.integer :component_id, null: false
      t.boolean :is_required_before_start, null: false, default: false

      t.timestamps
    end

    add_index :mes_component_step_usage_setup, [:step_code_id], name: 'idx_step_code_on_comp_step_use'

    create_table :mes_machine_types do |t|
      t.string  :name
      t.string  :description, limit: 2000
      t.integer :calibration_frequency_seconds
      t.integer :small_pm_frequency_seconds
      t.integer :large_pm_frequency_seconds

      t.timestamps
    end

    create_table :mes_machines do |t|
      t.string   :machine_code
      t.string   :description, limit: 2000
      t.integer  :machine_type_id, null: false
      t.datetime :last_calibration_time
      t.datetime :next_calibration_time
      t.date     :last_small_pm_time
      t.date     :next_small_pm_time
      t.date     :last_large_pm_time
      t.date     :next_large_pm_time
      t.integer  :status, default: 0 # defaults is idle status
      t.integer  :created_user_id, null: false

      t.timestamps
    end

    add_index :mes_machines, [:machine_type_id], name: 'idx_machine_type_on_machines'

    create_table :mes_machine_mappings do |t|
      # select field
      t.integer :step_code_id, null: false
      t.string  :product_machine_category
      # actural configure field
      t.integer :machine_type_id, null: false
      t.boolean :is_required_before_start, null: false, default: false

      t.timestamps
    end

    add_index :mes_machine_mappings, [:step_code_id], name: 'idx_step_code_on_machine_map'

    create_table :mes_tool_parts do |t|
      t.string  :tool_part, null: false
      t.string  :description, limit: 2000
      t.integer :calibration_frequency_seconds
      t.integer :pm_frequency_seconds
      t.integer :life_seconds
      t.integer :tool_consume_limit
      t.integer :unit_consume_limit
      t.string  :tool_type

      t.timestamps
    end

    create_table :mes_tools do |t|
      t.string   :tool_code
      t.integer  :tool_part_id, null: false
      t.integer  :status, default: 0 # defaults is idle status
      t.datetime :last_calibration_time
      t.datetime :next_calibration_time
      t.datetime :last_pm_time
      t.datetime :next_pm_time
      t.datetime :life_start
      t.datetime :life_expire
      t.integer  :tool_processed_count
      t.integer  :tool_processing_limit
      t.integer  :unit_processed_count
      t.integer  :unit_processing_limit

      t.timestamps
    end

    add_index :mes_tools, [:tool_part_id], name: 'idx_tool_part_id_on_tools'

    create_table :mes_tool_mappings do |t|
      # select field
      t.integer :step_code_id, null: false
      t.integer :machine_type_id, null: true
      t.string  :product_tool_category
      # actural configure field
      t.integer :tool_part_id, null: false
      t.boolean :is_required_before_start, null: false, default: false

      t.timestamps
    end

    add_index :mes_tool_mappings, [:step_code_id, :machine_type_id], name: 'idx_on_tool_mappings'

    create_table :mes_work_orders do |t|
      t.string  :work_order_name
      t.string  :order_type, null: false
      t.integer :product_id, null: false
      # No need to store product_code in table, will resolve to product_id when create
      t.integer :order_qty
      t.date    :released_date
      t.date    :due_date
      t.integer :status, default: 0 # defaults is pending status
      t.string  :factory, null: false
      t.string  :customer_no
      t.string  :packing_data
      t.string  :front_panel_smt_line
      t.string  :pack_panel_smt_line
      t.string  :firmware # the unit using firmware, we assure all units in work order using the same firmware.

      t.timestamps
    end

    add_index :mes_work_orders, [:product_id], name: 'idx_product_id_on_work_orders'

    create_table :mes_workflows do |t|
      t.string :name, null: false
      t.string :description, limit: 2000
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :mes_workflows, [:name], name: 'idx_on_workflows', unique: true

    create_table :mes_steps do |t|
      t.integer :workflow_id, null: false
      t.integer :step_code_id, null: false
      t.integer :sequence
      t.boolean :active, default: true
      # units_count is counter cache for the number of units belongs to such steps,
      # so can quick determine if for routing step, if unit is first or last latter
      t.integer :units_count, null: false, default: 0
      t.integer :lots_count, null: false, default: 0
      t.integer :step_hold_count, null: false, default: 0

      t.timestamps
    end

    add_index :mes_steps, [:workflow_id], name: 'idx_workflow_id_on_steps'
    add_index :mes_steps, [:step_code_id], name: 'idx_step_code_id_on_steps'

    create_table :mes_boms do |t|
      t.integer :work_order_id, null: false
      t.integer :component_id, null: false
      # No need to store component_code in table, will resolve to step_code_id when create.
      t.string  :component_instruction
      # No need to store component_description in table, will resolve to step_code_id when create.
      t.integer :qty_required
      t.boolean :stage_confirmed, default: false

      t.timestamps
    end

    add_index :mes_boms, [:work_order_id], name: 'idx_work_order_id_on_boms'

    # This is only required if the component is containerized.
    create_table :mes_staged_components do |t|
      t.integer  :bom_id, null: false
      t.integer  :component_id, null: false
      t.string   :sap_batch
      t.integer  :component_container_id
      t.integer  :qty_staged, default: 0
      t.datetime :stage_time
      t.integer  :user_id, null: false
      t.string   :vendor
      t.string   :vendor_lot

      t.timestamps
    end

    add_index :mes_staged_components, [:bom_id], name: 'idx_bom_id_on_stages'
    add_index :mes_staged_components, [:component_id], name: 'idx_component_id_on_stages'
    add_index :mes_staged_components, [:component_container_id], name: 'idx_comp_container_on_stages'

    create_table :mes_instructions do |t|
      t.integer :step_id, null: false
      t.string  :text
      t.timestamps
    end

    add_index :mes_instructions, [:step_id], name: 'idx_step_id_on_instructions'

    create_table :mes_step_allocated_components do |t|
      t.integer :step_id, null: false
      t.integer :component_container_id, null: false

      t.timestamps
    end

    add_index :mes_step_allocated_components, [:step_id], name: 'idx_step_id_on_step_components'

    create_table :mes_component_histories do |t|
      t.integer  :step_id, null: false
      t.integer  :user_id, null: false
      t.datetime :usage_time, null: false
    end

    add_index :mes_component_histories, [:step_id], name: 'idx_step_id_on_comp_histories'

    create_table :mes_component_history_details do |t|
      t.integer :component_history_id, null: false
      t.integer :component_container_id, null: false
    end

    add_index :mes_component_history_details, [:component_history_id], name: 'idx_comp_history_on_details'

    create_table :mes_step_allocated_machines do |t|
      t.integer :step_id, null: false
      t.integer :machine_id, null: false

      t.timestamps
    end

    add_index :mes_step_allocated_machines, [:step_id], name: 'idx_step_id_on_step_machines'

    create_table :mes_machine_histories do |t|
      t.integer  :step_id, null: false
      t.integer  :user_id, null: false
      t.datetime :usage_time, null: false
    end

    add_index :mes_machine_histories, [:step_id], name: 'idx_step_id_on_machine_history'

    create_table :mes_machine_history_details do |t|
      t.integer    :machine_history_id, null: false
      t.integer    :machine_id, null: false
    end

    add_index :mes_machine_history_details, [:machine_history_id], name: 'idx_machine_history_on_details'

    create_table :mes_step_allocated_tools do |t|
      t.integer    :step_id, null: false
      t.integer    :tool_id, null: false

      t.timestamps
    end

    add_index :mes_step_allocated_tools, [:step_id], name: 'idx_step_id_on_step_tools'

    create_table :mes_tool_histories do |t|
      t.integer  :step_id, null: false
      t.integer  :user_id, null: false
      t.datetime :usage_time, null: false
    end

    add_index :mes_tool_histories, [:step_id], name: 'idx_step_id_on_tool_histories'

    create_table :mes_tool_history_details do |t|
      t.integer  :tool_history_id, null: false
      t.integer  :tool_id, null: false
    end

    add_index :mes_tool_history_details, [:tool_history_id], name: 'idx_tool_history_id_on_details'

    create_table :mes_units do |t|
      t.string  :unit_sn, null: false # unit serial number
      t.integer :status, null: false, default: 0 # default 'in_queue'
      t.boolean :sap_confirmed
      t.string  :panel_number         # coming from CVS
      t.string  :cavity_number        # coming from CVS
      t.integer :tray_id
      t.string  :inner_box
      t.string  :outer_box
      t.string  :delivery_number
      t.string  :delivery_line
      t.integer :work_order_id
      t.integer :step_id, null: false
      t.integer :machine_id
      t.integer :last_routing_step_id, null: false
      t.integer :frwk_step_code_id # Future ReWorK step if exist.
      t.string  :frwk_defect_code
      t.integer :before_hold_status
      t.integer :hold_count, default: 0
      t.integer :total_defect_count, default: 0
      t.string  :reject_code
      t.string  :comment
      t.integer :product_id
      t.integer :basic_histories_count, null: false, default: 0
      t.integer :qty, null: false, default: 1
      t.string  :wwn # world wide serial number, generate at housing step
      t.string  :customer_serial_number # maybe various customer generate at housing step
      t.integer :created_user_id, null: false
      t.integer :updated_user_id, null: false

      t.timestamps
    end

    add_index :mes_units, :unit_sn, name: 'idx_unit_sn_on_units', unique: true
    add_index :mes_units, :work_order_id, name: 'idx_work_order_id_on_units'
    add_index :mes_units, :step_id, name: 'idx_step_id_on_units'
    add_index :mes_units, :product_id, name: 'idx_product_id_on_units'

    create_table :mes_lots do |t|
      t.string  :lot_no, null: false
      t.integer :status, null: false, default: 0 # default 'in_queue'
      t.integer :work_order_id
      t.integer :workflow_id, null: false
      t.integer :step_id, null: false
      t.integer :machine_id
      t.integer :before_hold_status
      t.integer :hold_count, default: 0
      t.string  :comment
      t.integer :factory_id, null: false
      t.integer :lot_type_id, null: false
      t.integer :product_id, null: false
      t.integer :basic_histories_count, null: false, default: 0
      t.integer :qty, null: false
      t.integer :wafer_qty
      t.string  :customer_number
      t.string  :customer_part_number
      t.integer :created_user_id, null: false
      t.integer :updated_user_id, null: false

      t.timestamps
    end

    add_index :mes_lots, :lot_no, name: 'idx_lot_no_on_lots', unique: true
    add_index :mes_lots, :work_order_id, name: 'idx_work_order_id_on_lots'
    add_index :mes_lots, :workflow_id, name: 'idx_workflow_id_on_lots'
    add_index :mes_lots, :step_id, name: 'idx_step_id_on_lots'
    add_index :mes_lots, :product_id, name: 'idx_product_id_on_lots'

    create_table :mes_lot_rejects do |t|
      t.integer :lot_id, null: false
      t.string  :lot_no, null: false
      t.integer :step_id, null: false
      t.string  :step_code, null: false
      t.string  :reject_code
      t.integer :reject_qty
      t.integer :reject_user_id, null: false
      t.string  :comment
      t.timestamps
    end

    add_index :mes_lot_rejects, :lot_no, name: 'idx_lot_no_on_lot_rejects'
    add_index :mes_lot_rejects, :lot_id, name: 'idx_lot_id_on_lot_rejects'
    add_index :mes_lot_rejects, :step_id, name: 'idx_step_id_on_lot_rejects'

    create_table :mes_lot_bins do |t|
      t.integer :lot_id, null: false
      t.string  :lot_no, null: false
      t.integer :step_id, null: false
      t.string  :step_code, null: false
      t.string  :bin_code
      t.integer :bin_qty
      t.integer :user_id, null: false
      t.string  :comment
      t.timestamps
    end

    add_index :mes_lot_bins, :lot_no, name: 'idx_lot_no_on_lot_bins'
    add_index :mes_lot_bins, :lot_id, name: 'idx_lot_id_on_lot_bins'
    add_index :mes_lot_bins, :step_id, name: 'idx_step_id_on_lot_bins'

    create_table :mes_lot_combine_histories do |t|
      t.integer :lot_id, null: false
      t.string  :lot_no, null: false
      t.integer :step_id, null: false
      t.string  :step_code, null: false
      t.integer :sub_lot_id, null: false
      t.string  :sub_lot_no, null: false
      t.integer :sub_lot_qty, null: false
      t.integer :user_id, null: false
      t.string  :comment
      t.timestamps
    end

    add_index :mes_lot_combine_histories, :lot_no, name: 'idx_lot_no_on_comb_histories'
    add_index :mes_lot_combine_histories, :lot_id, name: 'idx_lot_id_on_comb_histories'
    add_index :mes_lot_combine_histories, :step_id, name: 'idx_step_id_on_comb_histories'

    create_table :mes_lot_split_histories do |t|
      t.integer :lot_id, null: false
      t.string  :lot_no, null: false
      t.integer :step_id, null: false
      t.string  :step_code, null: false
      t.integer :sub_lot_id, null: false
      t.string  :sub_lot_no, null: false
      t.integer :sub_lot_qty, null: false
      t.integer :user_id, null: false
      t.string  :comment
      t.timestamps
    end

    add_index :mes_lot_split_histories, :lot_no, name: 'idx_lot_no_on_split_histories'
    add_index :mes_lot_split_histories, :lot_id, name: 'idx_lot_id_on_split_histories'
    add_index :mes_lot_split_histories, :step_id, name: 'idx_step_id_on_split_histories'

    create_table :mes_trays do |t|
      t.string  :tray_code, null: false
      t.integer :work_order_id, null: false

      t.timestamps
    end

    add_index :mes_trays, :tray_code, name: 'idx_tray_code_on_trays', unique: true

    create_table :mes_unit_basic_histories do |t|
      t.integer  :unit_id
      t.integer  :step_id
      t.integer  :step_sequence
      t.string   :step_code, null: false
      t.string   :unit_sn
      t.integer  :product_id
      t.string   :product_code
      t.integer  :work_order_id
      t.string   :work_order_name
      t.boolean  :is_rework
      t.datetime :in_queue_time, null: false
      t.datetime :start_process_time
      t.string   :step_result
      t.string   :reject_code
      t.string   :defect_code
      t.string   :failure_location
      t.string   :frwk_defect_code
      t.integer  :move_to_step_id
      t.string   :move_to_step_code
      t.datetime :move_time
      t.integer  :start_user_id
      t.integer  :component_history_id
      t.integer  :machine_history_id
      t.integer  :tool_history_id
      t.integer  :user_id
      t.string   :comment
      t.integer  :in_qty
      t.integer  :out_qty

      t.timestamps
    end

    add_index :mes_unit_basic_histories, :unit_sn, name: 'idx_unit_sn_on_unit_histories'
    add_index :mes_unit_basic_histories, :unit_id, name: 'idx_unit_id_on_unit_histories'
    add_index :mes_unit_basic_histories, :step_id, name: 'idx_step_id_on_unit_histories'
    add_index :mes_unit_basic_histories, :product_id, name: 'idx_pt_id_on_unit_histories'
    add_index :mes_unit_basic_histories, :work_order_id, name: 'idx_wo_id_on_unit_histories'

    create_table :mes_lot_basic_histories do |t|
      t.integer  :lot_id
      t.string   :lot_no
      t.integer  :step_id
      t.integer  :step_sequence
      t.string   :step_code, null: false
      t.integer  :product_id
      t.string   :product_code
      t.integer  :machine_id
      t.string   :machine_code
      t.integer  :work_order_id
      t.string   :work_order_name
      t.datetime :in_queue_time, null: false
      t.datetime :start_process_time
      t.integer  :move_to_step_id
      t.string   :move_to_step_code
      t.datetime :move_time
      t.integer  :start_user_id
      t.integer  :move_user_id
      t.string   :comment
      t.integer  :in_qty
      t.integer  :out_qty
      t.timestamps
    end

    add_index :mes_lot_basic_histories, :lot_no, name: 'idx_lot_no_on_lot_histories'
    add_index :mes_lot_basic_histories, :lot_id, name: 'idx_unit_id_on_lot_histories'
    add_index :mes_lot_basic_histories, :step_id, name: 'idx_step_id_on_lot_histories'
    add_index :mes_lot_basic_histories, :product_id, name: 'idx_pt_id_on_lot_histories'
    add_index :mes_lot_basic_histories, :work_order_id, name: 'idx_wo_id_on_lot_histories'

    create_table :mes_hold_release_histories do |t|
      t.integer  :container_id
      t.string   :container_name
      t.string   :class_name
      t.integer  :product_id
      t.integer  :work_order_id
      t.integer  :step_sequence
      t.integer  :step_id
      t.datetime :hold_time, null: false
      t.string   :hold_reason, null: false
      t.string   :hold_reason_description, null: false
      t.string   :hold_comment
      t.integer  :hold_user_id
      t.datetime :release_time
      t.string   :release_reason
      t.string   :release_reason_description
      t.string   :release_comment
      t.integer  :release_user_id

      t.timestamps
    end

    add_index :mes_hold_release_histories, :container_id, name: 'idx_container_id_on_uhlh'
    add_index :mes_hold_release_histories, :container_name, name: 'idx_container_name_on_uhlh'
    add_index :mes_hold_release_histories, :product_id, name: 'idx_product_id_on_uhlh'
    add_index :mes_hold_release_histories, :step_id, name: 'idx_step_id_on_uhlh'

    create_table :mes_step_hold_release_historys do |t|
      t.integer  :step_id
      t.string   :step_code_name
      t.integer  :product_id
      t.integer  :work_order_id
      t.datetime :hold_time, null: false
      t.string   :hold_reason, null: false
      t.string   :hold_reason_description, null: false
      t.string   :hold_comment
      t.datetime :release_time
      t.string   :release_reason
      t.string   :release_reason_description
      t.string   :release_comment

      t.timestamps
    end

    add_index :mes_step_hold_release_historys, :step_id, name: 'idx_step_id_on_shlh'
    add_index :mes_step_hold_release_historys, :step_code_name, name: 'idx_step_code_name_on_shlh'
    add_index :mes_step_hold_release_historys, :product_id, name: 'idx_product_id_on_shlh'
  end
end
