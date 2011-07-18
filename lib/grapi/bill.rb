module Grapi
  class Bill < Resource
    ENDPOINT = '/bills/:id'

    attr_accessor :amount
    attr_accessor :source_type

    # @attribute source_id
    # @return [Integer] the ID of the bill's source (eg subscription, pre_authorization)
    attr_accessor :source_id

    reference_accessor :merchant_id, :user_id, :payment_id
    date_accessor :created_at

    def source
      klass = Grapi.const_get(source_type.to_s.camelize)
      klass.find(@client, @source_id)
    end

    def source=(obj)
      klass = obj.class.to_s.split(':').last
      if !%w{Subscription PreAuthorization}.include?(klass)
        raise ArgumentError, ("Object must be an instance of Subscription or "
                              "PreAuthorization")
      end
      @source_id = obj.id
    end
  end
end
