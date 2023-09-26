# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Book Search', type: :poros do
  describe 'initialize', :vcr do
    it 'exists' do
      raw_data = { numFound: 772,
                   start: 0,
                   numFoundExact: true,
                   docs: [{ key: '/works/OL8503198W',
                            type: 'work',
                            seed: ['/books/OL10909613M', '/works/OL8503198W', '/authors/OL2843451A'],
                            title: 'Denver, Co',
                            title_suggest: 'Denver, Co',
                            title_sort: 'Denver, Co',
                            edition_count: 1,
                            edition_key: ['OL10909613M'],
                            publish_date: ['January 2001'],
                            publish_year: [2001],
                            first_publish_year: 2001,
                            isbn: %w[0762507845 9780762507849],
                            last_modified_i: 1_338_943_517,
                            ebook_count_i: 0,
                            ebook_access: 'no_ebook',
                            has_fulltext: false,
                            public_scan_b: false,
                            publisher: ['Universal Map Enterprises'],
                            language: ['eng'],
                            author_key: ['OL2843451A'],
                            author_name: ['Universal Map'],
                            publisher_facet: ['Universal Map Enterprises'],
                            _version_: 1_767_942_895_778_660_352,
                            author_facet: ['OL2843451A Universal Map'] },
                          { key: '/works/OL896607W',
                            type: 'work',
                            seed: ['/books/OL10945157M', '/works/OL896607W', '/authors/OL79165A'],
                            title: 'Denver west, CO and Bailey, CO: Denver, CO',
                            title_suggest: 'Denver west, CO and Bailey, CO: Denver, CO',
                            title_sort: 'Denver west, CO and Bailey, CO: Denver, CO',
                            subtitle: '39105, digital raster graphic data',
                            edition_count: 1,
                            edition_key: ['OL10945157M'],
                            publish_date: ['1996'],
                            publish_year: [1996],
                            first_publish_year: 1996,
                            isbn: %w[9780607620054 0607620056],
                            last_modified_i: 1_272_517_172,
                            ebook_count_i: 0,
                            ebook_access: 'no_ebook',
                            has_fulltext: false,
                            public_scan_b: false,
                            publisher: ['USGS Branch of Distribution'],
                            language: ['eng'],
                            author_key: ['OL79165A'],
                            author_name: ['United States Geological Survey'],
                            author_alternative_name: ['Geological Survey (U. S.)',
                                                      'Geological Survey (U.S.) 088',
                                                      'United States. Geological survey.',
                                                      'United States. Geological Survey',
                                                      'U.S. Geological Survey',
                                                      'Geological Survey. (U.S.)',
                                                      'Geological Survey (U .S.)',
                                                      'Geological Survey (U.S.)',
                                                      'United States. Geological Survey.'],
                            publisher_facet: ['USGS Branch of Distribution'],
                            _version_: 1_767_943_587_095_379_970,
                            author_facet: ['OL79165A United States Geological Survey'] }] }

      units = 'imperial'
      book_search = BookSearch.new('denver,co', raw_data, units)

      expect(book_search).to be_a(BookSearch)
      expect(book_search.id).to eq(nil)
      expect(book_search.destination).to eq('denver,co')
      expect(book_search.forecast).to be_a(Hash)
      expect(book_search.forecast[:summary]).to be_a(String)
      expect(book_search.forecast[:temperature]).to be_a(String)
      expect(book_search.total_books_found).to be_a(Integer)
      expect(book_search.books).to be_a(Array)
    end
  end
end
