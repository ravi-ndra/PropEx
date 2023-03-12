ActiveAdmin.register Property do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  permit_params do
    permitted = [:name, :description, :address, :city, :price, :user_id, :is_paid, :buyer_id, images: [] ]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  index do
    selectable_column
    column :id
    column :name
    column :description
    column :address
    column :city
    column :price, :sortable => :price do |property|
      div :class => "price" do
        number_to_currency property.price, :unit=>'₹'
      end
    end
    column :created_at
    column :updated_at
    column :user
    column :is_paid
    column :buyer_id do |property|
      User.find_by(id: property.buyer_id)
    end
    column "Images" do |property|
      ul do
        property.images.each do |img|
          li do 
            link_to image_tag(img, height: "50px", alt: "property_image")
          end
        end
      end
    end
    actions
  end

  form do |f|
    f.input :user, :as => :select, :collection => User.all.collect

    f.input :name
    f.input :description
    f.input :address
    f.input :city
    f.input :price
    f.input :images, as: :file, input_html: { multiple: true }
    f.actions
  end  
end
