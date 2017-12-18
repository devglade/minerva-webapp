class Post < ApplicationRecord
  belongs_to :user
  belongs_to :spin
  acts_as_votable

  after_create_commit do |post|
    html = ApplicationController.render partial: "posts/post", locals: {current_user: User.find(post.user_id), post: post}, formats: [:html]
    ActionCable.server.broadcast "posts", {action: "create", id: "post-#{post.id}", html: html}
    # PostBroadcastJobJob.perform_later(post, post.user_id)
  end


  # after_update do |question|
  #   update_tags(@__changed_tags__ + question.tags, question.user_id)
  #   ActsAsVotable::Vote.where(votable_id: question.id, votable_type: Question.name).update_all(tags: question.tags, user_id: question.user_id)
  # end
end
