# Create the expo provider register if it not already exists
unless Provider.by_label('expo').exists?
  Provider.create!({name: "Expo Push Notification",config: {}, delivery_class_name: 'Pushbox::Delivery::Expo',label: 'expo'})
end


System.create!(name: 'Default system', label: 'default_system') unless System.by_label('default_system').exists?
User.create!(name: 'Default Client User', role: :client) unless User.where(name: 'Default Client User').exists?
User.create!(name: 'Default Admin User', role: :admin) unless User.where(name: 'Default Admin User').exists?

Tag.create!(name: 'Tag 1', label:"tag1") unless Tag.where(label: 'tag1').exists?
Tag.create!(name: 'Tag 2', label:"tag2") unless Tag.where(label: 'tag2').exists?
Tag.create!(name: 'Tag 3', label:"tag3") unless Tag.where(label: 'tag3').exists?

Topic.create!(title: 'Topic 1') unless Topic.where(title: 'Topic 1').exists?
Topic.create!(title: 'Topic 1') unless Topic.where(title: 'Topic 1').exists?