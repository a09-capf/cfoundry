require "cfoundry/v2/service_instance"

module CFoundry::V2
  class UserProvidedServiceInstance < ServiceInstance
    attribute :credentials, :hash
    attribute :parameters, :hash

    def self.object_name
      'service_instance'
    end

    def create_endpoint_name
      'user_provided_service_instances'
    end
  end
end
