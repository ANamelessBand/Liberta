tags = [
        'Roman',
        'Novel',
        'Programming',
        'Art',
        'Music',
        'Java',
        'C#',
        'Ruby',
        'Python',
        'SciFi',
        'Crime fiction',
        'Adventure',
        'Stories',
        'Audiobook',
        'Poetry',
        'Classic',
        'Fiction',
        'Fantasy',
        'Science',
        'Health',
        'History',
        'Horror',
       ]

tags.each do |tag_name|
  dummy_tag = Tag.new name: tag_name
  dummy_tag.save if dummy_tag.valid?
end
