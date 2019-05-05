# frozen_string_literal: true

module CommentsHelper
	def comments_container_id(commentable)
		"#{commentable.class.to_s.downcase}-#{commentable.id}-comments"
	end

	def comment_form_id(commentable)
		"#{commentable.class.to_s.downcase}-#{commentable.id}-comment-form"
	end
end
