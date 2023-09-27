# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

module Scrapers
  class Company
    attr_accessor :url

    SITE_URL = 'https://www.ajot.com/premium/ajot-top-100-trucking-companies'
    JSON_DATA_FILE_PATH = Rails.root.join('public', 'json', 'companies.json').to_s.freeze

    CompanyData = Struct.new(:name, :city, :state)

    def initialize
      @url = SITE_URL
    end

    def call
      company_data = build_company_data(company_table_rows)
      save_data(company_data)
      create_companies(company_data)
    end

    def build_company_data(row_data)
      row_data[1..].map do |data|
        attrs = data.css('td')[1..]
        CompanyData.new(
          name: attrs[0].text.squish,
          city: attrs[1].text.squish,
          state: attrs[2].text.squish
        )
      end
    end

    def company_table_rows
      rows = scrape_data(parse_html)
      rows.map(&:children)
    end

    def create_companies(company_data_collection)
      company_data_collection.each do |company_data|
        ::Company.create_or_find_by!(
          name: company_data.name
        ).tap do |company|
          company.city = company_data.city
          company.state = company_data.state
          company.save! if company.changed?
        end
      end
    end

    private

    def parse_html
      URI.open(url)
    end

    def save_data(data)
      json_data = data.to_json
      File.write(FILE_PATH, json_data, mode: 'w+')
    end

    def scrape_data(html)
      doc = Nokogiri::HTML(html)
      table_rows = doc.css('table').css('tr')
      table_rows[1..]
    end
  end
end
