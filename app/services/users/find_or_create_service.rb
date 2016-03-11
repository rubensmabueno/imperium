module Users
  class FindOrCreateService
    attr_reader :attributes

    def self.call(attributes)
      new(attributes).call
    end

    def initialize(attributes)
      @attributes = attributes
    end

    def call
      find || create
    end

    private

    def find
      User.find_by(provider: attributes['provider'], uid: attributes['uid'])
    end

    def create
      User.create!(
        provider: attributes['provider'],
        uid: attributes['uid'],
        name: attributes['info']['name'],
        token: attributes['credentials']['token']
      )
    end
  end
end
