# frozen_string_literal: true

class DocumentsController < ApplicationController
  before_action :set_document, only: %i[download destroy]
  before_action :authenticate_user!
  before_action :verify_admin, only: %i[create destroy]

  # GET /documents or /documents.json
  def index
    @documents = Document.all
  end

  def download
    file = @document.file
    if file.attached?
      send_data file.download, filename: file.filename.to_s, type: file.content_type,
                               disposition: 'attachment'
    else
      redirect_to documents_path, alert: I18n.t('documents.download.alert')
    end
  end

  # POST /documents or /documents.json
  def create
    @document = create_and_sanitize_document

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: I18n.t('documents.create.notice') }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { redirect_to documents_path, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    attachment = @document.file
    attachment.purge if attachment.attached?
    @document.destroy!

    respond_to do |format|
      format.html { redirect_to documents_path, status: :see_other, notice: I18n.t('documents.destroy.notice') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def document_params
    params.require(:document).permit(:file)
  end

  def create_and_sanitize_document
    document = Document.new(document_params)
    return document unless document.file.attached?

    # Sanitize the filename to prevent directory traversal attacks
    document.file.filename = sanitize_filename(document.file.filename.to_s)

    document
  end

  def sanitize_filename(filename)
    filename.strip.tap do |name|
      # NOTE: File.basename doesn't work right with Windows paths on Unix
      # get only the filename, not the whole path
      name.sub!(%r{\A.*(\\|/)}, '')
      # Finally, replace all non alphanumeric, underscore or periods with underscore
      name.gsub!(/[^\w.-]/, '_')
    end
  end
end
