object @profile

attributes :name, :designation, :address, :phone_number, :pincode

node(:profile_pic) { |profile| profile.profile_pic.present? ? profile.profile_pic : nil  }