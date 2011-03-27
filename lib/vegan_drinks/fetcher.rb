module VeganDrinks
  class Fetcher
    BR = /<br\s*\/?>/i

    protected

    def info(*args)
      VeganDrinks.logger.info(*args)
    end

    def debug(*args)
      VeganDrinks.logger.debug(*args)
    end

  end
end