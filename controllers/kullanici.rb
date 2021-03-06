get "/kullanicilar/giris/" do
  kullanici_giris
  if session[:user_id].nil?
    erb :'kullanicilar/giris'
  else
    redirect "/"
  end
end
get "/kullanicilar/cikis/" do
  kullanici_giris
  session[:user_id] = nil
  redirect "/"
end
post "/kullanicilar/giris/" do
  kullanici_giris
  kadi = params["kullanici_adi"]
  parola = params["parola"]

  sonuc = Kullanici.giris(kadi,parola)
  if sonuc.count == 0
    flash[:sonuc] = "Kullanıcı Adınız Veya Parolanız Hatalı."
    redirect "/kullanicilar/giris/"
  else
    sonuc.each do |kullanici|
      puts kullanici['admin_mi'] , "Kullanici Yetkisi"
      if kullanici['admin_mi'] == 1
        session[:user_id] = kullanici['idKullanicilar']
        flash[:sonuc] = "Başarıyla giriş yaptınız."
        redirect "/yonetici/"
      else
        kullanici = Kullanici.new(kullanici['idKullanicilar'],kullanici['kullanici_adi'],kullanici['adi'],kullanici['soyadi'],kullanici['parola'],kullanici['resim_url'],kullanici['admin_mi'])
        session[:user_id] = kullanici.id
        flash[:sonuc] = "Başarıyla giriş yaptınız."
        redirect "/"
      end
    end
  end
end


get "/kullanicilar/kayitol/" do
  kullanici_giris
  erb :'kullanicilar/kayitol'
end

post "/kullanicilar/kayitol/" do
  kullanici_giris
  id = nil
  kullanici_adi = params["kullanici_adi"]
  adi = params["adi"]
  soyadi = params["soyadi"]
  parola = params["parola"]
  resim = params["resim"]
  admin_mi = 0
  kullanici = Kullanici.new(id,kullanici_adi,adi,soyadi,parola,resim,admin_mi)
  kullanici.olustur()
  flash[:sonuc] = "Kullanici başarıyla oluşturuldu. Lütfen giriş yapınız. Teşekkürler."
  redirect "/kullanicilar/giris/"
end
get '/kullanicilar/:username/' do
  kullanici_giris
  kullanici_adi = params['username']
  @bu_kullanici  = Kullanici.kullanici_adi_ile_ara(kullanici_adi)
  @satin_almalar = SatinAl.aldiklari(@bu_kullanici.id)

  erb :'kullanicilar/profil'
end

def kullanici_giris
  if session[:user_id]
    @kullanici = Kullanici.id_ile_ara(session['user_id'].inspect)
  end
end
