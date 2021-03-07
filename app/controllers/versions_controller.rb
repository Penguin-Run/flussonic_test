require 'date'

class VersionsController < ApplicationController
  before_action :parse_params, only: :index

  NUM_OF_RELEASES_TO_TAKE = 5
  class FlussonicLastVersion
    LAST_VERSION_FISH = '20.10'.freeze
    def self.get
      LAST_VERSION_FISH
    end
  end

  def index
    # достаем из БД License по указанному в get-запросе id
    license = License.find_by(id: @license_id)
    if license
      @paid_till = license.paid_till
      # парсим в дату, по дефолту выставляем первый день месяца
      @max_version = license.max_version ? Date.parse(license.max_version + '.01') : nil
      @min_version = license.min_version ? Date.parse(license.min_version + '.01') : nil

      # достаем последнюю версию из сервиса и парсим в дату, по дефолту выставляем первый день месяца
      last_version = FlussonicLastVersion.get # TODO: проверка на невалидный ответ
      last_version = Date.parse(last_version + '.01')

      # берем пять последних релизов Flussonic
      fill_arr = Enumerator.new do |yielded|
        current = last_version
        loop do
          yielded.yield current
          current -= 1.month
        end
      end
      versions_list = fill_arr.take_while { |el| el > last_version - NUM_OF_RELEASES_TO_TAKE.month }

      print(versions_list)

      # фильтруем список версий в соответствии с правилами
      versions_list = versions_list.select do |el|
        is_max = true; is_paid = true; is_min = true
        is_max = el <= @max_version if @max_version
        is_paid = el <= @paid_till
        is_min = el >= @min_version if @min_version
        is_max && is_paid && is_min
      end
      versions_list = [@max_version] if versions_list.empty?

      # TODO: вывести в формате гг.мм (возможно сделать в отдельной функции)
      respond_data = { availableVersions: versions_list.map { |el| { version: el.year.to_s + '.' + el.month.to_s  } } }
    else
      respond_data = { errorMessage: "Given license id doesn't exist or invalid" }
    end

    respond_to do |format|
      format.xml { render xml: respond_data.to_xml }
      format.rss { render xml: respond_data.to_xml }
    end
  end

  def parse_params
    @license_id = params[:id]
  end
end

