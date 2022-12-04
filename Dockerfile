FROM public.ecr.aws/lambda/provided:al2

RUN yum install -y gzip mariadb awscli && \
  yum clean all && rm -rf /var/cache/yum

COPY runtime/bootstrap ${LAMBDA_RUNTIME_DIR}
COPY task/function.sh ${LAMBDA_TASK_ROOT}

CMD [ "function.handler" ]
