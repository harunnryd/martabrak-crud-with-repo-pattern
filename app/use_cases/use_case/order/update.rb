module UseCase
  module Order
    class Update
      def self.call(order, attrs, callbacks, repository = OrderRepository.new)
        new(order, attrs, callbacks, repository).call
      end

      def call
        order.assign_attributes(attrs)
        if repository.save(order)
          callbacks.fetch(:success).call(order)
        else
          callbacks.fetch(:failure).call(order)
        end
      end

      private
        def initialize(order, attrs, callbacks, repository)
          @order = order
          @attrs = attrs
          @callbacks = callbacks
          @repository = repository
        end

        attr_reader(:order, :attrs, :callbacks, :repository)
    end
  end
end
