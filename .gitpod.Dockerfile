FROM baneeishaque/gitpod-workspace-full-vnc-1366x768-tint2-pcmanfm-zsh-android-sdk

ARG androidStudioDownloadUrl="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/4.1.3.0/android-studio-ide-201.7199119-linux.tar.gz"
# TODO : Derive androidStudioInstallationFile from androidStudioDownloadUrl
ARG androidStudioInstallationFile="android-studio-ide-201.7199119-linux.tar.gz"

# RUN sudo apt update \
 # && sudo apt install -y \
    # libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386 \
 # && sudo rm -rf /var/lib/apt/lists/*

RUN cd $HOME \
 && wget $androidStudioDownloadUrl | tee -a /tmp/wget-androidStudio.log \
 && sudo tar -xvf $androidStudioInstallationFile -C /usr/local/ | tee -a /tmp/tar-androidStudio.log\
 && rm $androidStudioInstallationFile

RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh && sdk install java 8.0.242-open /usr/local/android-studio/jre && sdk default java 8.0.242-open"
ENV JAVA_HOME="$HOME/.sdkman/candidates/java/current" 

RUN cd $HOME \
 && sudo apt update | tee -a /tmp/apt.log \
 && sudo apt install -y \
     dos2unix | tee -a /tmp/apt.log \
 && sudo rm -rf /var/lib/apt/lists/*

RUN sed -i 's/plugins=(git)/plugins=(git gradle)/g' ~/.zshrc
