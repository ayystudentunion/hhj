class ContactsController < ApplicationController
  def create
    # TODO: save our contact
    @contact = @university.contacts.build params[:contact]
    unless @contact.save
      flash[:errors_title] = I18n.t('shared.error_messages.title', class: @contact.model_name.human.downcase)
      flash[:errors] = @contact.errors.full_messages
    end
    redirect_to request.referer
  end

  def destroy
   Contact.find(params[:id]).destroy
   redirect_to request.referer
  end

  def new
    @contact = Contact.new
    @form_path = contacts_path
    respond_to do |format|
      format.fragment
    end
  end  
end
