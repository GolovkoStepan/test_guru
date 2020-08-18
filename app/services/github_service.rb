# frozen_string_literal: true

class GithubService
  delegate :logger, to: Rails

  class GithubResponse
    attr_reader :success, :url

    def initialize(success: false, url: nil)
      @success = success
      @url = url
    end
  end

  def create_question_gist(user:, question:)
    with_any_errors do
      logger.info 'Start to create gist'
      response = client.create_gist(question_gist_params(user, question))
      gist_url = response.html_url
      gist_id  = response.id

      if gist_url && gist_id
        logger.info "Gist created. URL: #{gist_url}, ID: #{gist_id}"
        save_gist_info(user, question, gist_url, gist_id)
        GithubResponse.new success: true, url: gist_url
      else
        logger.info 'Error while creating gist'
        GithubResponse.new
      end
    end
  end

  def remove_gist(gist_id:)
    with_any_errors do
      logger.info "Remove gist from GitHub with id: #{gist_id}"
      if client.delete_gist(gist_id)
        logger.info 'Gist removed successfully'
        remove_gist_info(gist_id)
        GithubResponse.new success: true
      else
        logger.info 'Error while removing gist'
        GithubResponse.new
      end
    end
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  end

  def question_gist_params(user, question)
    {
      description: "Unclear question, user: #{user.email}",
      public: true,
      files: {
        'test_guru_question.txt' => {
          content: question_gist_content(question)
        }
      }
    }
  end

  def question_gist_content(question)
    content = [question.body]
    content += question.answers.pluck(:body)
    content.join("\n")
  end

  def save_gist_info(user, question, url, id)
    logger.info 'Saving gist info to DB'
    Gist.create!(user: user, question: question, url: url, gist_id: id)
    logger.info 'Gist saved successfully'
  end

  def remove_gist_info(gist_id)
    gist_info = Gist.find_by(gist_id: gist_id)

    if gist_info
      logger.info "Remove gist info from DB with gist id: #{gist_id}"
      gist_info.destroy!
      logger.info 'Gist info removed successfully'
    else
      logger.info "Gist info with gist id [#{gist_id}] not found"
    end
  end

  def with_any_errors
    yield
  rescue StandardError => e
    logger.info "Error while execution: #{e.class}"
    logger.info "Error message: #{e.message}"
    GithubResponse.new
  end
end
