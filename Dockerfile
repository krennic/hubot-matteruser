FROM node:argon

RUN useradd -m -s /bin/bash hubot-matteruser && \
	mkdir -p /usr/src/hubot-matteruser && \
	chown hubot-matteruser:hubot-matteruser /usr/src/hubot-matteruser && \
	chown hubot-matteruser:hubot-matteruser /usr/local/lib/node_modules/ && \
	chown hubot-matteruser:hubot-matteruser /usr/local/bin/

WORKDIR /usr/src/hubot-matteruser

USER hubot-matteruser

RUN npm install -g yo generator-hubot  && \
	#Install custom scripts
	npm install --save \
	mattermost-slashbot \
	hubot-voting \
	hubot-terminal-calendar \
	hubot-birthday-reminder \
	hubot-remind-her \
	hubot-remind-advanced \
	hubot-onboarding \
	hubot-dns-watch \
	hubot-babyfoot \
	hubot-vsphere-commands \
	hubot-gitlab \
	hubot-sonarqube \
	hubot-jira-links \
	hubot-jira-bot \
	hubot-cron-events 
	
RUN echo "No" | yo hubot --adapter matteruser --owner="krennic" --name="alfred" --description="un larbin à votre disposition" --defaults && \
	sed -i '/heroku/d' external-scripts.json && \
	rm hubot-scripts.json

COPY external-scripts.json external-scripts.json

CMD ["-a", "matteruser"]
ENTRYPOINT ["./bin/hubot"]

EXPOSE 8080