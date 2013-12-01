module Liberta
  module PrintsHelpers
    def search(titles, authors, tags, publishers, searchables)
      dataset = print_search_dataset

      if searchables.empty?
        dataset = search_titles      titles,      dataset
        dataset = search_authors     authors,     dataset
        dataset = search_publishers  publishers,  dataset
        dataset = search_tags        tags,        dataset
      else
        dataset = search_searchables searchables, dataset
      end

      dataset.select_all(:prints).distinct
    end

    private

    def print_search_dataset
      Print.join(:authors_prints,
                 authors_prints__print_id: :prints__id)
            .join(:authors,
                  authors__id: :authors_prints__author_id)
            .join(:publishers,
                  publishers__id: :prints__publisher_id)
            .join(:prints_tags,
                  prints_tags__print_id: :prints__id)
            .join(:tags, tags__id: :prints_tags__tag_id)
    end

    def search_titles(titles, dataset)
      dataset = dataset.where Sequel.ilike(:prints__title, "%#{titles.first}%")
      titles.each do |title|
        dataset = dataset.where Sequel.ilike(:prints__title, "%#{title}%")
      end

      dataset
    end

    def search_authors(authors, dataset)
      authors.each do |author|
        dataset = dataset.where Sequel.ilike(:authors__name, "%#{author}%")
      end

      dataset
    end

    def search_publishers(publishers, dataset)
      publishers.each do |publisher|
        dataset = dataset.where Sequel.ilike(:publishers__name, "%#{publisher}%")
      end

      dataset
    end

    def search_tags(tags, dataset)
      tags.each do |tag|
        dataset = dataset.where Sequel.ilike(:tags__name, "%#{tag}%")
      end

      dataset
    end

    def search_searchables(searchables, dataset)
      join_clause = Sequel.join [
                                  :prints__title,
                                  :authors__name,
                                  :publishers__name,
                                  :tags__name,
                                ], ' '

      searchables.each do |searchable|
        dataset = dataset.where join_clause.ilike("%#{searchable}%")
      end

      dataset
    end
  end
end
