publishers = [
              'Prosveta',
              'Chitanka',
              'Bulvest 2000',
              'Kiril i Metodiy',
              'Siela-Soft',
              'Taushanov i co.',
              'Orkestar bez ime',
             ]

publishers.each do |publisher_name|
  dummy_publisher = Publisher.new name: publisher_name
  dummy_publisher.save if dummy_publisher.valid?
end
