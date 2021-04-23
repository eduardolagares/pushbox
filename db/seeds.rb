# Create the expo provider register if it not already exists
unless Provider.by_label('expo').exists?

  Provider.create!({
                     name: "Expo Push Notification",
                     config: {},
                     delivery_class_name: 'ExpoProviderDelivery',
                     synced_topics: false,
                     label: 'expo'
                   })
end
