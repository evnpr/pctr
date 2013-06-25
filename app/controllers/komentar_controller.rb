class KomentarController < ApplicationController
  def postkomentar
        current_user
        komentar = params[:komentar]
        issue_id = params[:issue_id]
        Komentar.create(:message => komentar, :issue_id => issue_id, :user_id => @current_user.id)
        redirect_to request.referer, :notice => "success" and return
  end

  def vote
        current_user
        komentar_id = params[:id]
        paramvote = params[:vote]
        if !@current_user
            redirect_to request.referer and return
        end
        user_id = @current_user.id
        if !Vote.exists?(:user_id => user_id, :komentar_id => komentar_id)
            vote = Vote.new(:user_id => user_id, :komentar_id => komentar_id) 
            komentar = Komentar.find(komentar_id)
            if paramvote == "biasa"
                komentar.biasa = komentar.biasa + 1
                komentar.user.biasa = komentar.user.biasa + 1
                vote.vote = "biasa"
            elsif paramvote == "bermutu"
                komentar.bermutu = komentar.bermutu + 1
                komentar.user.bermutu = komentar.user.bermutu + 1
                vote.vote = "bermutu"
            elsif paramvote == "gakmutu"
                komentar.gakmutu = komentar.gakmutu + 1
                komentar.user.gakmutu = komentar.user.gakmutu + 1
                vote.vote = "gakmutu"
            end
        else    
            vote = Vote.where(:user_id => user_id, :komentar_id => komentar_id).first
            komentar = Komentar.find(komentar_id)
            if vote.vote == "biasa"
                komentar.biasa = komentar.biasa - 1
                komentar.user.biasa = komentar.user.biasa - 1
            elsif vote.vote == "bermutu"
                komentar.bermutu = komentar.bermutu - 1
                komentar.user.bermutu = komentar.user.bermutu - 1
            elsif vote.vote == "gakmutu"
                komentar.gakmutu = komentar.gakmutu - 1
                komentar.user.gakmutu = komentar.user.gakmutu - 1
            end
            if paramvote == "biasa"
                komentar.biasa = komentar.biasa + 1
                komentar.user.biasa = komentar.user.biasa + 1
                vote.vote = "biasa"
            elsif paramvote == "bermutu"
                komentar.bermutu = komentar.bermutu + 1
                komentar.user.bermutu = komentar.user.bermutu + 1
                vote.vote = "bermutu"
            elsif paramvote == "gakmutu"
                komentar.gakmutu = komentar.gakmutu + 1
                komentar.user.gakmutu = komentar.user.gakmutu + 1
                vote.vote = "gakmutu"
            end
        end
        komentar.user.save
        komentar.save
        vote.save
        redirect_to request.referer+"#k#{komentar_id}" and return
  end
end
