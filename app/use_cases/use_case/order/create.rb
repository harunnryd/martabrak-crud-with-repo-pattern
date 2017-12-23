module UseCase
  module Order
    class Create
      def self.call(attrs, callbacks, repository = OrderRepository.new)
        new(attrs, callbacks, repository).call
      end

      def call
        order = repository.new_entity(attrs)
        if repository.save(order)
          callbacks.fetch(:success).call(order)
        else
          callbacks.fetch(:failure).call(order)
        end
      end

      private
        def initialize(attrs, callbacks, repository)
          @attrs = attrs
          @callbacks = callbacks
          @repository = repository
        end

        attr_reader(:attrs, :callbacks, :repository)
    end
  end
end
