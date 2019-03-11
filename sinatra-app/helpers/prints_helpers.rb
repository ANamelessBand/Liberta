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

    def notify_copy_is_free(print)
      User.wishing(print).each do |user|
        Notification.free_copy user, print
      end
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

      search_attribute(titles, :prints__title, dataset)
    end

    def search_authors(authors, dataset)
      search_attribute(authors, :authors__name, dataset)
    end

    def search_publishers(publishers, dataset)
      search_attribute(publishers, :publishers__name, dataset)
    end

    def search_tags(tags, dataset)
      search_attribute(tags, :tags__name, dataset)
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

    def search_attribute(collection, attribute, dataset)
      collection.each do |item|
        dataset = dataset.where Sequel.ilike(attribute, "%#{item}%")
      end

      dataset
    end
  end
end
