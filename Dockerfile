FROM public.ecr.aws/lambda/provided:al2 as build

RUN yum install -y gzip mariadb unzip

ADD https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip /opt/awscli.zip
RUN cd /opt && unzip -q awscli.zip


FROM public.ecr.aws/lambda/provided:al2

COPY --from=build /usr/bin/gzip /usr/bin/mysqldump /usr/local/bin/
COPY --from=build /opt/aws /opt/aws
RUN ln -s /opt/aws/dist/aws /usr/local/bin/


COPY runtime/bootstrap ${LAMBDA_RUNTIME_DIR}
COPY task/function.sh ${LAMBDA_TASK_ROOT}

CMD [ "function.handler" ]
