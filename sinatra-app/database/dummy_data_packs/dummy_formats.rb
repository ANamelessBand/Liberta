formats = [
            'book',
            'magazine',
            'newspaper',
            'publication',
          ]

formats.each do |format_name|
  dummy_format = Format.new name: format_name
  dummy_format.save if dummy_format.valid?
end
