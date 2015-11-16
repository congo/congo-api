ActiveAdmin.register Account do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params  :list, :of, :attributes, :on, :model, :name,
     :slug,
       :tagline,
       :plan_name,

      # TODO: What fields do we need?
   :properties_data,

      # Payment info (TODO: Do we still need these?)
       :card_number,
       :month,
       :year,
       :cvc,
 :billing_start,
      :billing_day,



       :deleted_at,
      :deleted_at
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
