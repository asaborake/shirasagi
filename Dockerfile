FROM centos:centos7

#System Update
RUN yum -y update
RUN yum -y install wget git ImageMagick ImageMagick-devel which

#MongoDB Install
COPY mongodb-org-3.4.repo /etc/yum.repos.d/mongodb-org-3.4.repo
RUN yum install -y --enablerepo=mongodb-org-3.4 mongodb-org

#Ruby(RVM) Install
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.4.4"
RUN /bin/bash -l -c "rvm use 2.4.4 --default"
RUN /bin/bash -l -c "gem install bundler"

#SHIRASAGI Install
WORKDIR /var/www/shirasagi
RUN git clone -b stable --depth 1 https://github.com/shirasagi/shirasagi .
RUN cp -n config/samples/*.{yml,rb} config/
RUN /bin/bash -l -c "bundle install --without development test"
