module ApplicationHelper
  def profile_image_tag(user, options = {})
    default_options = {
        width: 100,
        height: 100,
        crop: :lfill,
        alt: user.name
    }
    options = default_options.merge(options)

    # return fetch_image_tag(user.image_id, options) if (user.image_id =~ /(?:https?:\/\/)/) != nil
    return cl_image_tag(user.image_id, options) if user.image_id
    default_profile_image_tag(options)
  end

  def default_profile_image_tag(options)
    default_options = {
        width: 100,
        height: 100,
        alt: 'Profile Image'
    }
    options = default_options.merge(options)
    image_tag('img_profile_default.png', options)
  end

end
