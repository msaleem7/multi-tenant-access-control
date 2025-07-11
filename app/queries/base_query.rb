# frozen_string_literal: true

class BaseQuery
  include Pundit::Authorization

  def initialize(current_user, base_scope = nil)
    @current_user = current_user
    @scope = policy_scope(
      base_scope || self.class.model,
      policy_scope_class: self.class.policy_scope_class
    )
  end

  # Don't provide a policy class by default, let it be inferred from the model
  # automatically. Override it if your policy class is specific and cannot be
  # determined based on the model (e.g. SomeNamespace::SomePolicy::Scope
  # for SomeNamespace::SomeModel objects).
  def self.policy_scope_class
    nil
  end

  def self.model
    raise NotImplementedError, "Implement self.model in #{self.class}"
  end

  private

  attr_reader :current_user

  attr_accessor :scope

  def pundit_user
    current_user
  end

  def basic_filtered_list(params)
    filter(params)
    scope
  end
end
