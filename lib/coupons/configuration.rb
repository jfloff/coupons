module Coupons
  class Configuration
    # Set the list of resolvers.
    attr_accessor :resolvers

    # Set the token generator.
    attr_accessor :generator

    # Set the authorizer.
    attr_accessor :authorizer

    # Set the coupon finder strategy.
    attr_accessor :finder

    # Set pagination lib.
    attr_accessor :pagination_adapter

    # Set the paginator strategy.
    attr_accessor :paginator

    # Set the page size.
    attr_accessor :per_page

    def initialize
      @resolvers = [Resolver.new]
      @generator = Generator.new
      @finder = Finders::FirstAvailable
      @per_page = 50

      # loads pagination according to loaded gem
      # should fallback to paginate gem
      if Gem.loaded_specs.has_key?('kaminari')
        @pagination_adapter =:kaminari
        @paginator = -> relation, page { relation.page(page).per(Coupons.configuration.per_page) }
      elsif Gem.loaded_specs.has_key?('paginate')
        @pagination_adapter = :paginate
        @paginator = -> relation, page { relation.paginate(page: page, size: Coupons.configuration.per_page) }
      end

      @authorizer = proc do |controller|
        if Rails.env.production?
          controller.render(
            text: 'Coupons: not enabled in production environments',
            status: 403
          )
        end
      end
    end
  end
end
