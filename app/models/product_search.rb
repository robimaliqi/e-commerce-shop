class ProductSearch
  def self.call(params)
    new(params).call
  end

  def initialize(params)
    @params = params
  end

  def call
    products
      .where(search_condition)
      .where(price_condition)
      .order(sort_condition)
  end

  private

  def products
    @products ||= Product.all
  end

  def search_condition
    return unless @params.dig(:search, :query)

    ["name LIKE ?", "%#{@params.dig(:search, :query)}%"]
  end

  def price_condition
    return unless @params.dig(:search, :price)
    conditions = [].tap do |array|
      array << (..100) if @params.dig(:search, :price).include?("lt100")
      array << (100..250) if @params.dig(:search, :price).include?("bewteen100and250")
      array << (250..) if @params.dig(:search, :price).include?("gt250")
    end
    { price: conditions }
  end

  def sort_condition
    return unless @params.dig(:search, :sort)

    case @params.dig(:search, :sort)
    when "price_lth"
      { price: :asc }
    when "price_htl"
      { price: :desc }
    end
  end

end