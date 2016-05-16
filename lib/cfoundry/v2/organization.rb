require 'cfoundry/v2/model'
require "cfoundry/v2/helper"

module CFoundry::V2
  class Organization < Model
    extend Helper

    attribute :name, :string
    attribute :billing_enabled, :boolean
    attribute :status, :string

    to_many   :spaces
    to_many   :domains
    to_many   :users
    to_many   :managers, :as => :user
    to_many   :billing_managers, :as => :user
    to_many   :auditors, :as => :user

    to_many_support   :spaces
    to_many_support   :domains
    to_many_support   :users
    to_many_support   :managers
    to_many_support   :billing_managers
    to_many_support   :auditors

    to_one    :quota_definition

    queryable_by :name, :space_guid, :user_guid, :manager_guid,
      :billing_manager_guid, :auditor_guid

    def delete_user_from_all_roles(user)
      remove_user(user)
      remove_manager(user)
      remove_billing_manager(user)
      remove_auditor(user)

      spaces.each do |space|
        space.remove_developer(user)
        space.remove_auditor(user)
        space.remove_manager(user)
      end
    end
  end
end
