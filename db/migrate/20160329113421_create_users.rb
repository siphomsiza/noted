class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, force: :cascade do |t|
        t.string :firstname, null: false
        t.string :email, index: true, unique: true
        t.string  :title
        t.string :surname
  	    t.string  :gender
  	    t.string  :race
  	    t.string  :occupational_category
  	    t.boolean  :disabled
        t.boolean  :terminated, default: false
  	    t.string  :disability_description
  	    t.string  :employee_number, unique: true
  	    t.date  :employment_date
  	    t.string  :job_title
  	    t.string  :location
  	    t.string  :manager
  	    t.string  :country_prefix
  	    t.string  :landline
  	    t.string  :mobile, unique: true
  	    t.string  :fax
      	t.string  :status, default: "New"
        t.integer  :login_count, default: 0
        t.integer  :login_attempts,default: 0
        t.integer  :max_login_attempts,default: 3
        t.datetime :last_login
        t.datetime  :current_login_at
        t.datetime  :terminated_at
        t.string  :last_login_ip
        t.string  :current_login_ip
        t.string  :reset_digest
        t.strind  :active_log
    	  t.datetime  :reset_sent_at
    	  t.boolean  :admin, default: false
        t.boolean  :support, default: false
        t.boolean  :standard_user, default: false
        t.boolean  :assurance, default: false
    	  t.string  :activation_digest
    	  t.boolean  :activated, default: false
    	  t.datetime  :activated_at
     	  t.string  :remember_digest
     	  t.string  :password_digest
        t.integer :department_id, foreign_key: true
      	t.timestamps null: false
    end
  end
end
