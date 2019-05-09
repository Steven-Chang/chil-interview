# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :login_required

  def create
    @subscription = Subscription.new(permitted_params)
    authorize @subscription, :create?
    @subscribable = @subscription.subscribable
    @subscription.process_new_request(params, current_user)
    redirect_to @subscribable,
                notice: "Thanks Brett and Dan for reviewing!\nLet me know if you have any questions or need anything else.\nSteve"
  end

  private

  def permitted_params
    params.require(:subscription).permit(
      :subscribable_id,
      :subscribable_type,
      :subscription_option_id
    )
  end
end
