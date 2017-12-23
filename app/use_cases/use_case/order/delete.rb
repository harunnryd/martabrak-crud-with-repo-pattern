module UseCase
  module Order
    class Delete
      def self.call(order, callbacks, repository = OrderRepository.new)
        new(order, callbacks, repository).call
      end

      def call
        if repository.delete(order)
          callbacks.fetch(:success).call
        else
          callbacks.fetch(:failure).call
        end
      end

      private
        def initialize(order, callbacks, repository)
          @order = order
          @callbacks = callbacks
          @repository = repository
        end

        attr_reader(:order, :callbacks, :repository)
    end
  end
end
