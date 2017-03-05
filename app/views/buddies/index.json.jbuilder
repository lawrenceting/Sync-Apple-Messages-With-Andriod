json.array! @buddies, partial: 'buddies/buddy', as: :buddy if current_user.admin?
