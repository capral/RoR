class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_user.subscribed_posts << @post
    redirect_to @post,
                notice: 'Вы успешно подписаны на обновления'

    def destroy
      subscription = Subscription.find(params[:id])
      subscription.destroy if current_user_id == subscription.user_id
      redirect_to subscription.post, notice: 'Вы отписались от подписки'
    end
  end
end