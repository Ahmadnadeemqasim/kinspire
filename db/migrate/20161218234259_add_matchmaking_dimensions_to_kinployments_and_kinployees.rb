class AddMatchmakingDimensionsToKinploymentsAndKinployees < ActiveRecord::Migration[5.0]
  def change

    ##
    # Kinployments

    add_column :kinployments, :preferred_availability,    :integer
    add_column :kinployments, :cultural_backgrounds,      :text
    add_column :kinployments, :culture_match_preference,  :string
    add_column :kinployments, :preferred_languages,       :text
    add_column :kinployments, :location,                  :text
    add_column :kinployments, :preferred_sex,             :string
    add_column :kinployments, :preferred_skills,          :text

    ##
    # Kinployees

    add_column :kinployees, :availability,              :integer
    add_column :kinployees, :cultural_backgrounds,      :text
    add_column :kinployees, :culture_match_preference,  :string
    add_column :kinployees, :languages,                 :text
    add_column :kinployees, :location,                  :text
    add_column :kinployees, :sex,                       :string
    add_column :kinployees, :skills,                    :text
  end
end
