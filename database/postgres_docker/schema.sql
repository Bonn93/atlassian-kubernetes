/* Users */
CREATE USER hipchat;
CREATE USER hipchat_prod;
CREATE USER jira;
CREATE USER jira_prod;
CREATE USER crowd;
CREATE USER crowd_prod;
CREATE USER confluence;
CREATE USER confluence_prod;
CREATE USER bitbucket;
CREATE USER bitbucket_prod;
CREATE USER bamboo;
CREATE USER bamboo_prod;
CREATE USER fecru;
CREATE USER fecru_prod;
CREATE USER jirasd;
CREATE USER jirasd_prod;

/* Databases */
CREATE DATABASE hipchat;
CREATE DATABASE hipchat_prod;

CREATE DATABASE jira WITH ENCODING 'UNICODE' LC_COLLATE 'C' LC_CTYPE 'C' TEMPLATE template0;

CREATE DATABASE jira_prod;

CREATE DATABASE crowd;
CREATE DATABASE crowd_prod;

CREATE DATABASE confluence;
CREATE DATABASE confluence_prod;

CREATE DATABASE bitbucket;
CREATE DATABASE bitbucket_prod;

CREATE DATABASE bamboo;
CREATE DATABASE bamboo_prod;

CREATE DATABASE fecru;
CREATE DATABASE fecru_prod;

CREATE DATABASE jirasd;
CREATE DATABASE jirasd_prod;

/* Permissions
 Hipchat DC */
GRANT ALL privileges ON DATABASE hipchat TO hipchat;
ALTER USER hipchat WITH PASSWORD 'hipchat';

GRANT ALL privileges ON DATABASE hipchat_prod TO hipchat_prod;
ALTER USER hipchat_prod WITH PASSWORD 'hipchat_prod';
/* JIRA */
GRANT ALL privileges ON DATABASE jira TO jira;
ALTER USER jira WITH PASSWORD 'jira';

GRANT ALL privileges ON DATABASE jira_prod TO jira_prod;
ALTER USER jira_prod WITH PASSWORD 'jira_prod';
/* Crowd */
GRANT ALL privileges ON DATABASE crowd TO crowd;
ALTER USER crowd WITH PASSWORD 'crowd';

GRANT ALL privileges ON DATABASE crowd_prod TO crowd_prod;
ALTER USER crowd_prod WITH PASSWORD 'crowd_prod';
/* Confluence */
GRANT ALL privileges ON DATABASE confluence TO confluence;
ALTER USER confluence WITH PASSWORD 'confluence';

GRANT ALL privileges ON DATABASE confluence_prod TO confluence_prod;
ALTER USER confluence_prod WITH PASSWORD 'confluence_prod';
/* Bitbucket */
GRANT ALL privileges ON DATABASE bitbucket TO bitbucket;
ALTER USER bitbucket WITH PASSWORD 'bitbucket';

GRANT ALL privileges ON DATABASE bitbucket_prod TO bitbucket_prod;
ALTER USER bitbucket_prod WITH PASSWORD 'bitbucket_prod';
/* Bamboo */
GRANT ALL privileges ON DATABASE bamboo TO bamboo;
ALTER USER bamboo WITH PASSWORD 'bamboo';

GRANT ALL privileges ON DATABASE bamboo_prod TO bamboo_prod;
ALTER USER bamboo_prod WITH PASSWORD 'bamboo_prod';
/* Fecru */
GRANT ALL privileges ON DATABASE fecru TO fecru;
ALTER USER fecru WITH PASSWORD 'fecru';

GRANT ALL privileges ON DATABASE fecru_prod TO fecru_prod;
ALTER USER fecru_prod WITH PASSWORD 'fecru_prod';

/* JSD */
GRANT ALL privileges ON DATABASE jirasd TO jirasd;
ALTER USER jirasd WITH PASSWORD 'jirasd';

GRANT ALL privileges ON DATABASE jirasd_prod TO jirasd_prod;
ALTER USER jirasd_prod WITH PASSWORD 'jirasd_prod';
