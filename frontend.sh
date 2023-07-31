source common.sh

echo -e  "\e[36m>>>>>> install nginx <<<<<<\e[0m" | tee -a /tmp.roboshop.log
yum install nginx -y &>>${log}
func_exit_status

echo -e  "\e[36m>>>>>> copy roboshop configuration <<<<<<\e[0m" | tee -a /tmp.roboshop.log
cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log}
func_exit_status

echo -e  "\e[36m>>>>>> clean old content <<<<<<\e[0m" | tee -a /tmp.roboshop.log
rm -rf /usr/share/nginx/html/* &>>${log}
func_exit_status

echo -e  "\e[36m>>>>>> download application content <<<<<<\e[0m" | tee -a /tmp.roboshop.log
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log}
func_exit_status

cd /usr/share/nginx/html

echo -e  "\e[36m>>>>>> extract  application content <<<<<<\e[0m" | tee -a /tmp.roboshop.log
unzip /tmp/frontend.zip &>>${log}
func_exit_status

echo -e  "\e[36m>>>>>> start nginx service <<<<<<\e[0m" | tee -a /tmp.roboshop.log
systemctl enable nginx &>>${log}
systemctl restart nginx &>>${log}
func_exit_status