FROM node:argon

RUN apt-get update && \
	apt-get install -y nano && \
	rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash hubot-matteruser && \
	mkdir -p /usr/src/hubot-matteruser && \
	chown hubot-matteruser:hubot-matteruser /usr/src/hubot-matteruser && \
	chown hubot-matteruser:hubot-matteruser /usr/local/lib/node_modules/ && \
	chown hubot-matteruser:hubot-matteruser /usr/local/bin/

WORKDIR /usr/src/hubot-matteruser

USER hubot-matteruser

RUN npm install -g yo generator-hubot &&\
	npm install --save \
	hubot-sonarqube \
	hubot-jira-bot \
	hubot-jira-links
	
RUN echo "No" | yo hubot --adapter matteruser --owner="krennic" --name="alfred" --description="un larbin à votre disposition" --defaults && \
	rm hubot-scripts.json

COPY external-scripts.json external-scripts.json

CMD ["-a", "matteruser"]
ENTRYPOINT ["./bin/hubot"]

EXPOSE 8080