# Create the expo provider register if it not already exists
if !Provider.by_alias('expo').exists?

    Provider.create!({
        name: "Expo Push Notification",
        config: {},
        delivery_class_name: 'ExpoProviderDelivery',
        synced_topics: false,
        alias: 'expo'
    })
end
