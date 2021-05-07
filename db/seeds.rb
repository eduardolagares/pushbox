# Create the expo provider register if it not already exists
unless Provider.by_label('expo').exists?

  provider = Provider.create!({
                     name: "Expo Push Notification",
                     config: {},
                     delivery_class_name: 'Pushbox::Delivery::Expo',
                     label: 'expo'
                   })

  # system = System.create!(name: 'App React', label: "app_cliente")

  # user = User.create!(name: 'Teste do Wagner', api_key: 'GQHQRCLYORVUXAAWDNEQFEDTDZ', role: :client)

  # topic = Topic.create!(title: 'Topico de Teste')
end
