
CREATE TABLE ofUser (
  username              NVARCHAR(64)    NOT NULL,
  storedKey             VARCHAR(32),
  serverKey             VARCHAR(32),
  salt                  VARCHAR(32),
  iterations            INTEGER,
  plainPassword         NVARCHAR(32),
  encryptedPassword     NVARCHAR(255),
  name                  NVARCHAR(100),
  email                 VARCHAR(100),
  creationDate          CHAR(15)        NOT NULL,
  modificationDate      CHAR(15)        NOT NULL,
  CONSTRAINT ofUser_pk PRIMARY KEY (username)
);
CREATE INDEX ofUser_cDate_idx ON ofUser (creationDate ASC);


CREATE TABLE ofUserProp (
  username              NVARCHAR(64)    NOT NULL,
  name                  NVARCHAR(100)   NOT NULL,
  propValue             NVARCHAR(2000)  NOT NULL,
  CONSTRAINT ofUserProp_pk PRIMARY KEY (username, name)
);


CREATE TABLE ofUserFlag (
  username              NVARCHAR(64)    NOT NULL,
  name                  NVARCHAR(100)   NOT NULL,
  startTime             CHAR(15),
  endTime               CHAR(15),
  CONSTRAINT ofUserFlag_pk PRIMARY KEY (username, name)
);
CREATE INDEX ofUserFlag_sTime_idx ON ofUserFlag (startTime ASC);
CREATE INDEX ofUserFlag_eTime_idx ON ofUserFlag (endTime ASC);


CREATE TABLE ofOffline (
  username              NVARCHAR(64)    NOT NULL,
  messageID             INTEGER         NOT NULL,
  creationDate          CHAR(15)        NOT NULL,
  messageSize           INTEGER         NOT NULL,
  stanza                NTEXT           NOT NULL,
  CONSTRAINT ofOffline_pk PRIMARY KEY (username, messageID)
);


CREATE TABLE ofPresence (
  username              NVARCHAR(64)     NOT NULL,
  offlinePresence       NTEXT,
  offlineDate           CHAR(15)     NOT NULL,
  CONSTRAINT ofPresence_pk PRIMARY KEY (username)
);


CREATE TABLE ofRoster (
  rosterID              INTEGER         NOT NULL,
  username              NVARCHAR(64)    NOT NULL,
  jid                   NVARCHAR(1024)  NOT NULL,
  sub                   INTEGER         NOT NULL,
  ask                   INTEGER         NOT NULL,
  recv                  INTEGER         NOT NULL,
  nick                  NVARCHAR(255),
  stanza                NTEXT,
  CONSTRAINT ofRoster_pk PRIMARY KEY (rosterID)
);
CREATE INDEX ofRoster_username_idx ON ofRoster (username ASC);
CREATE INDEX ofRoster_jid_idx ON ofRoster (jid ASC);


CREATE TABLE ofRosterGroups (
  rosterID              INTEGER         NOT NULL,
  rank                  INTEGER         NOT NULL,
  groupName             NVARCHAR(255)   NOT NULL,
  CONSTRAINT ofRosterGroups_pk PRIMARY KEY (rosterID, rank)
);
CREATE INDEX ofRosterGroups_rosterid_idx ON ofRosterGroups (rosterID ASC);
ALTER TABLE ofRosterGroups ADD CONSTRAINT ofRosterGroups_rosterID_fk FOREIGN KEY (rosterID) REFERENCES ofRoster;


CREATE TABLE ofVCard (
  username              NVARCHAR(64)    NOT NULL,
  vcard                 NTEXT           NOT NULL,
  CONSTRAINT ofVCard_pk PRIMARY KEY (username)
);


CREATE TABLE ofGroup (
  groupName             NVARCHAR(50)   NOT NULL,
  description           NVARCHAR(255),
  CONSTRAINT ofGroup_pk PRIMARY KEY (groupName)
);


CREATE TABLE ofGroupProp (
   groupName            NVARCHAR(50)   NOT NULL,
   name                 NVARCHAR(100)   NOT NULL,
   propValue            NVARCHAR(2000)  NOT NULL,
   CONSTRAINT ofGroupProp_pk PRIMARY KEY (groupName, name)
);


CREATE TABLE ofGroupUser (
  groupName             NVARCHAR(50)    NOT NULL,
  username              NVARCHAR(100)   NOT NULL,
  administrator         INTEGER         NOT NULL,
  CONSTRAINT ofGroupUser_pk PRIMARY KEY (groupName, username, administrator)
);


CREATE TABLE ofID (
  idType                INTEGER         NOT NULL,
  id                    INTEGER         NOT NULL,
  CONSTRAINT ofID_pk PRIMARY KEY (idType)
);


CREATE TABLE ofProperty (
  name        NVARCHAR(100) NOT NULL,
  propValue   NTEXT NOT NULL,
  encrypted   INTEGER,
  iv          CHAR(24),
  CONSTRAINT ofProperty_pk PRIMARY KEY (name)
);


CREATE TABLE ofVersion (
  name     NVARCHAR(50) NOT NULL,
  version  INTEGER  NOT NULL,
  CONSTRAINT ofVersion_pk PRIMARY KEY (name)
);

CREATE TABLE ofExtComponentConf (
  subdomain             NVARCHAR(255)    NOT NULL,
  wildcard              INT              NOT NULL,
  secret                NVARCHAR(255),
  permission            NVARCHAR(10)     NOT NULL,
  CONSTRAINT ofExtComponentConf_pk PRIMARY KEY (subdomain)
);

CREATE TABLE ofRemoteServerConf (
  xmppDomain            NVARCHAR(255)    NOT NULL,
  remotePort            INTEGER,
  permission            NVARCHAR(10)     NOT NULL,
  CONSTRAINT ofRemoteServerConf_pk PRIMARY KEY (xmppDomain)
);

CREATE TABLE ofPrivacyList (
  username              NVARCHAR(64)    NOT NULL,
  name                  NVARCHAR(100)   NOT NULL,
  isDefault             INT             NOT NULL,
  list                  NTEXT           NOT NULL,
  CONSTRAINT ofPrivacyList_pk PRIMARY KEY (username, name)
);
CREATE INDEX ofPrivacyList_default_idx ON ofPrivacyList (username, isDefault);

CREATE TABLE ofSASLAuthorized (
  username        NVARCHAR(64)     NOT NULL,
  principal       NVARCHAR(2000)   NOT NULL,
  CONSTRAINT ofSASLAuthorized_pk PRIMARY KEY (username, principal)
);

CREATE TABLE ofSecurityAuditLog (
  msgID                 INTEGER         NOT NULL,
  username              NVARCHAR(64)    NOT NULL,
  entryStamp            BIGINT          NOT NULL,
  summary               NVARCHAR(255)   NOT NULL,
  node                  NVARCHAR(255)   NOT NULL,
  details               NTEXT,
  CONSTRAINT ofSecurityAuditLog_pk PRIMARY KEY (msgID)
);
CREATE INDEX ofSecurityAuditLog_tstamp_idx ON ofSecurityAuditLog (entryStamp);
CREATE INDEX ofSecurityAuditLog_uname_idx ON ofSecurityAuditLog (username);

/* MUC Tables */

CREATE TABLE ofMucService (
  serviceID           INT           NOT NULL,
  subdomain           NVARCHAR(255) NOT NULL,
  description         NVARCHAR(255),
  isHidden            INT           NOT NULL,
  CONSTRAINT ofMucService_pk PRIMARY KEY (subdomain)
);
CREATE INDEX ofMucService_serviceid_idx ON ofMucService(serviceID);

CREATE TABLE ofMucServiceProp (
  serviceID           INT           NOT NULL,
  name                NVARCHAR(100) NOT NULL,
  propValue           NVARCHAR(2000) NOT NULL,
  CONSTRAINT ofMucServiceProp_pk PRIMARY KEY (serviceID, name)
);

CREATE TABLE ofMucRoom (
  serviceID           INT           NOT NULL,
  roomID              INT           NOT NULL,
  creationDate        CHAR(15)      NOT NULL,
  modificationDate    CHAR(15)      NOT NULL,
  name                NVARCHAR(50)  NOT NULL,
  naturalName         NVARCHAR(255) NOT NULL,
  description         NVARCHAR(255),
  lockedDate          CHAR(15)      NOT NULL,
  emptyDate           CHAR(15)      NULL,
  canChangeSubject    INT           NOT NULL,
  maxUsers            INT           NOT NULL,
  publicRoom          INT           NOT NULL,
  moderated           INT           NOT NULL,
  membersOnly         INT           NOT NULL,
  canInvite           INT           NOT NULL,
  roomPassword        NVARCHAR(50)  NULL,
  canDiscoverJID      INT           NOT NULL,
  logEnabled          INT           NOT NULL,
  subject             NVARCHAR(100) NULL,
  rolesToBroadcast    INT           NOT NULL,
  useReservedNick     INT           NOT NULL,
  canChangeNick       INT           NOT NULL,
  canRegister         INT           NOT NULL,
  allowpm             INT           NULL,
  fmucEnabled         INT           NULL,
  fmucOutboundNode    NVARCHAR(255) NULL,
  fmucOutboundMode    INT           NULL,
  fmucInboundNodes    NVARCHAR(2000) NULL,
  CONSTRAINT ofMucRoom_pk PRIMARY KEY (serviceID, name)
);
CREATE INDEX ofMucRoom_roomid_idx on ofMucRoom(roomID);
CREATE INDEX ofMucRoom_serviceid_idx on ofMucRoom(serviceID);

CREATE TABLE ofMucRoomProp (
  roomID                INT             NOT NULL,
  name                  NVARCHAR(100)   NOT NULL,
  propValue             NVARCHAR(2000)  NOT NULL,
  CONSTRAINT ofMucRoomProp_pk PRIMARY KEY (roomID, name)
);

CREATE TABLE ofMucAffiliation (
  roomID              INT            NOT NULL,
  jid                 NVARCHAR(424) NOT NULL,
  affiliation         INT            NOT NULL,
  CONSTRAINT ofMucAffiliation_pk PRIMARY KEY (roomID,jid)
);

CREATE TABLE ofMucMember (
  roomID              INT            NOT NULL,
  jid                 NVARCHAR(424)  NOT NULL,
  nickname            NVARCHAR(255)  NULL,
  firstName           NVARCHAR(100)  NULL,
  lastName            NVARCHAR(100)  NULL,
  url                 NVARCHAR(100)  NULL,
  email               NVARCHAR(100)  NULL,
  faqentry            NVARCHAR(100)  NULL,
  CONSTRAINT ofMucMember_pk PRIMARY KEY (roomID,jid)
);

CREATE TABLE ofMucConversationLog (
  roomID              INT            NOT NULL,
  messageID         INT           NOT NULL,
  sender              NVARCHAR(1024) NOT NULL,
  nickname            NVARCHAR(255)  NULL,
  logTime             CHAR(15)       NOT NULL,
  subject             NVARCHAR(255)  NULL,
  body                NTEXT          NULL,
  stanza                NTEXT          NULL
);
CREATE INDEX ofMucConversationLog_roomtime_idx ON ofMucConversationLog (roomID, logTime);
CREATE INDEX ofMucConversationLog_time_idx ON ofMucConversationLog (logTime);
CREATE INDEX ofMucConversationLog_msg_id ON ofMucConversationLog (messageID);

/* PubSub Tables */

CREATE TABLE ofPubsubNode (
  serviceID           NVARCHAR(100)  NOT NULL,
  nodeID              NVARCHAR(100)  NOT NULL,
  leaf                INT            NOT NULL,
  creationDate        CHAR(15)       NOT NULL,
  modificationDate    CHAR(15)       NOT NULL,
  parent              NVARCHAR(100)  NULL,
  deliverPayloads     INT            NOT NULL,
  maxPayloadSize      INT            NULL,
  persistItems        INT            NULL,
  maxItems            INT            NULL,
  notifyConfigChanges INT            NOT NULL,
  notifyDelete        INT            NOT NULL,
  notifyRetract       INT            NOT NULL,
  presenceBased       INT            NOT NULL,
  sendItemSubscribe   INT            NOT NULL,
  publisherModel      NVARCHAR(15)   NOT NULL,
  subscriptionEnabled INT            NOT NULL,
  configSubscription  INT            NOT NULL,
  accessModel         NVARCHAR(10)   NOT NULL,
  payloadType         NVARCHAR(100)  NULL,
  bodyXSLT            NVARCHAR(100)  NULL,
  dataformXSLT        NVARCHAR(100)  NULL,
  creator             NVARCHAR(255)  NOT NULL,
  description         NVARCHAR(255)  NULL,
  language            NVARCHAR(255)  NULL,
  name                NVARCHAR(50)   NULL,
  replyPolicy         NVARCHAR(15)   NULL,
  associationPolicy   NVARCHAR(15)   NULL,
  maxLeafNodes        INT            NULL,
  CONSTRAINT ofPubsubNode_pk PRIMARY KEY (serviceID, nodeID)
);

CREATE TABLE ofPubsubNodeJIDs (
  serviceID           NVARCHAR(100)  NOT NULL,
  nodeID              NVARCHAR(100)  NOT NULL,
  jid                 NVARCHAR(250) NOT NULL,
  associationType     NVARCHAR(20)   NOT NULL,
  CONSTRAINT ofPubsubNodeJIDs_pk PRIMARY KEY (serviceID, nodeID, jid)
);

CREATE TABLE ofPubsubNodeGroups (
  serviceID           NVARCHAR(100)  NOT NULL,
  nodeID              NVARCHAR(100)  NOT NULL,
  rosterGroup         NVARCHAR(100)  NOT NULL
);
CREATE INDEX ofPubsubNodeGroups_idx ON ofPubsubNodeGroups (serviceID, nodeID);

CREATE TABLE ofPubsubAffiliation (
  serviceID           NVARCHAR(100)  NOT NULL,
  nodeID              NVARCHAR(100)  NOT NULL,
  jid                 NVARCHAR(250)  NOT NULL,
  affiliation         NVARCHAR(10)   NOT NULL,
  CONSTRAINT ofPubsubAffiliation_pk PRIMARY KEY (serviceID, nodeID, jid)
);

CREATE TABLE ofPubsubItem (
  serviceID           NVARCHAR(100)  NOT NULL,
  nodeID              NVARCHAR(100)  NOT NULL,
  id                  NVARCHAR(100)  NOT NULL,
  jid                 NVARCHAR(1024) NOT NULL,
  creationDate        CHAR(15)       NOT NULL,
  payload             NTEXT          NULL,
  CONSTRAINT ofPubsubItem_pk PRIMARY KEY (serviceID, nodeID, id)
);

CREATE TABLE ofPubsubSubscription (
  serviceID           NVARCHAR(100)  NOT NULL,
  nodeID              NVARCHAR(100)  NOT NULL,
  id                  NVARCHAR(100)  NOT NULL,
  jid                 NVARCHAR(1024) NOT NULL,
  owner               NVARCHAR(1024) NOT NULL,
  state               NVARCHAR(15)   NOT NULL,
  deliver             INT            NOT NULL,
  digest              INT            NOT NULL,
  digest_frequency    INT            NOT NULL,
  expire              CHAR(15)       NULL,
  includeBody         INT            NOT NULL,
  showValues          NVARCHAR(30)   NOT NULL,
  subscriptionType    NVARCHAR(10)   NOT NULL,
  subscriptionDepth   INT            NOT NULL,
  keyword             NVARCHAR(200)  NULL,
  CONSTRAINT ofPubsubSubscription_pk PRIMARY KEY (serviceID, nodeID, id)
);

CREATE TABLE ofPubsubDefaultConf (
  serviceID           NVARCHAR(100) NOT NULL,
  leaf                INT           NOT NULL,
  deliverPayloads     INT           NOT NULL,
  maxPayloadSize      INT           NOT NULL,
  persistItems        INT           NOT NULL,
  maxItems            INT           NOT NULL,
  notifyConfigChanges INT           NOT NULL,
  notifyDelete        INT           NOT NULL,
  notifyRetract       INT           NOT NULL,
  presenceBased       INT           NOT NULL,
  sendItemSubscribe   INT           NOT NULL,
  publisherModel      NVARCHAR(15)  NOT NULL,
  subscriptionEnabled INT           NOT NULL,
  accessModel         NVARCHAR(10)  NOT NULL,
  language            NVARCHAR(255) NULL,
  replyPolicy         NVARCHAR(15)  NULL,
  associationPolicy   NVARCHAR(15)  NOT NULL,
  maxLeafNodes        INT           NOT NULL,
  CONSTRAINT ofPubsubDefaultConf_pk PRIMARY KEY (serviceID, leaf)
);

INSERT INTO ofVersion (name, version) VALUES ('openfire', 34);

/* Entry for admin user */
INSERT INTO ofUser (username, plainPassword, name, email, creationDate, modificationDate)
    VALUES ('admin', 'admin', 'Administrator', 'admin@example.com', '0', '0');

/* Entry for default conference service */
INSERT INTO ofMucService (serviceID, subdomain, isHidden) VALUES 
(1, 'conference', 0);


INSERT INTO ofid (idtype, id) VALUES
(18, 11),
(19, 1),
(26, 2),
(23, 6),
(27, 51),
(25, 7);

INSERT INTO ofmucaffiliation (roomid, jid, affiliation) VALUES
(1, 'admin@xmpp.localhost.example', 10),
(2, 'admin@xmpp.localhost.example', 10);


INSERT INTO ofmucconversationlog (roomid, messageid, sender, nickname, logtime, subject, body, stanza) VALUES
(1, 1, 'muc1@conference.xmpp.localhost.example', NULL, 001605193216988, NULL, '', '<message type="groupchat" from="muc1@conference.xmpp.localhost.example" to="muc1@conference.xmpp.localhost.example"><subject></subject></message>'),
(2, 2, 'muc2@conference.xmpp.localhost.example', NULL, 001605193235014, NULL, '', '<message type="groupchat" from="muc2@conference.xmpp.localhost.example" to="muc2@conference.xmpp.localhost.example"><subject></subject></message>');


INSERT INTO ofmucroom (serviceid, roomid, creationdate, modificationdate, name, naturalname, description, lockeddate, emptydate, canchangesubject, maxusers, publicroom, moderated, membersonly, caninvite, roompassword, candiscoverjid, logenabled, subject, rolestobroadcast, usereservednick, canchangenick, canregister, allowpm, fmucenabled, fmucoutboundnode, fmucoutboundmode, fmucinboundnodes) VALUES
(1, 1, 001605193216969, 001605193216979, 'muc1', 'MUC One', 'First MUC room', 000000000000000, NULL, 0, 30, 1, 0, 0, 0, NULL, 1, 1, '', 7, 0, 1, 1, 0, 0, NULL, NULL, NULL),
(1, 2, 001605193235007, 001605193235010, 'muc2', 'MUC Two', 'Second MUC room', 000000000000000, NULL, 0, 30, 1, 0, 0, 0, NULL, 1, 1, '', 7, 0, 1, 1, 0, 0, NULL, NULL, NULL);


INSERT INTO ofproperty (name, propvalue, encrypted, iv) VALUES
('xmpp.socket.ssl.active', 'true', 0, NULL),
('provider.admin.className', 'org.jivesoftware.openfire.admin.DefaultAdminProvider', 0, NULL),
('xmpp.domain', 'xmpp.localhost.example', 0, NULL),
('xmpp.auth.anonymous', 'false', 0, NULL),
('provider.auth.className', 'org.jivesoftware.openfire.auth.DefaultAuthProvider', 0, NULL),
('provider.lockout.className', 'org.jivesoftware.openfire.lockout.DefaultLockOutProvider', 0, NULL),
('provider.group.className', 'org.jivesoftware.openfire.group.DefaultGroupProvider', 0, NULL),
('provider.vcard.className', 'org.jivesoftware.openfire.vcard.DefaultVCardProvider', 0, NULL),
('provider.securityAudit.className', 'org.jivesoftware.openfire.security.DefaultSecurityAuditProvider', 0, NULL),
('provider.user.className', 'org.jivesoftware.openfire.user.DefaultUserProvider', 0, NULL),
('passwordKey', 'YJ1nKWyrMeGvTKu', 0, NULL),
('update.lastCheck', '1605956807055', 0, NULL);


INSERT INTO ofpubsubaffiliation (serviceid, nodeid, jid, affiliation) VALUES
('pubsub', '', 'xmpp.localhost.example', 'owner');


INSERT INTO ofpubsubdefaultconf (serviceid, leaf, deliverpayloads, maxpayloadsize, persistitems, maxitems, notifyconfigchanges, notifydelete, notifyretract, presencebased, senditemsubscribe, publishermodel, subscriptionenabled, accessmodel, language, replypolicy, associationpolicy, maxleafnodes) VALUES
('pubsub', 1, 1, 10485760, 0, 1, 1, 1, 1, 0, 1, 'publishers', 1, 'open', 'English', NULL, 'all', -1),
('pubsub', 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 'publishers', 1, 'open', 'English', NULL, 'all', -1);


INSERT INTO ofpubsubnode (serviceid, nodeid, leaf, creationdate, modificationdate, parent, deliverpayloads, maxpayloadsize, persistitems, maxitems, notifyconfigchanges, notifydelete, notifyretract, presencebased, senditemsubscribe, publishermodel, subscriptionenabled, configsubscription, accessmodel, payloadtype, bodyxslt, dataformxslt, creator, description, language, name, replypolicy, associationpolicy, maxleafnodes) VALUES
('pubsub', '', 0, 001605193079586, 001605193079586, NULL, 0, 0, 0, 0, 1, 1, 1, 0, 0, 'publishers', 1, 0, 'open', '', '', '', 'xmpp.localhost.example', '', 'English', '', NULL, 'all', -1)


INSERT INTO ofroster (rosterid, username, jid, sub, ask, recv, nick) VALUES
(1, 'user3', 'user1@xmpp.localhost.example', 3, -1, -1, 'user1'),
(2, 'user1', 'user3@xmpp.localhost.example', 3, -1, -1, 'user3'),
(3, 'user2', 'user1@xmpp.localhost.example', 3, -1, -1, 'user1'),
(4, 'user1', 'user2@xmpp.localhost.example', 3, -1, -1, 'user2'),
(5, 'user2', 'user3@xmpp.localhost.example', 3, -1, -1, 'user3'),
(6, 'user3', 'user2@xmpp.localhost.example', 3, -1, -1, 'user2');


INSERT INTO ofrostergroups (rosterid, rank, groupname) VALUES
(1, 0, 'Friends'),
(2, 0, 'Friends'),
(3, 0, 'Friends'),
(4, 0, 'Friends'),
(5, 0, 'Friends'),
(6, 0, 'Friends');


INSERT INTO ofsecurityauditlog (msgid, username, entrystamp, summary, node, details) VALUES
(1, 'admin', 1605193086180, 'Successful admin console login attempt', 'xmpp1.localhost.example', 'The user logged in successfully to the admin console from address 172.60.0.1.'), 
(2, 'admin', 1605193167191, 'created new user ''user1''', 'xmpp1.localhost.example', 'name = User One, email = null, admin = false'),
(3, 'admin', 1605193178661, 'created new user ''user2''', 'xmpp1.localhost.example', 'name = User Two, email = null, admin = false'),
(4, 'admin', 1605193216992, 'created new MUC room muc1', 'xmpp1.localhost.example', 'subject = '''',roomdesc = First MUC room, roomname = MUC One, maxusers = 30'),
(5, 'admin', 1605193235018, 'created new MUC room muc2', 'xmpp1.localhost.example', 'subject = '''',roomdesc = Second MUC room, roomname = MUC Two, maxusers = 30'),
(6, 'admin', 1605957429200, 'created new user ''user3''', 'xmpp2.localhost.example', 'name = null, email = null, admin = false');


INSERT INTO ofuser (username, storedkey, serverkey, salt, iterations, plainpassword, encryptedpassword, name, email, creationdate, modificationdate) VALUES
('user1', 'bwwYjdvCySlDbPP8ThRhIRPNIsg=', 'kghyw1bnKARQIQFnq1ro4EeC24s=', '2q5Haus5PeiKO6T0U7BWPW6p+6B2xNPv', 4096, NULL, 'd8835ca5c85385d31b06e30d0479559f241d3c6c9bfe37b5a2ee228a258a73b8', 'User One', NULL, 001605193167159, 001605193167159),
('user2', 'qQZJ/YRNwP4ongfV375LPUlDkeE=', 't0pnVWMK/9MAEBGYka0bNJfYe/Q=', 'nl9R20qgvMHcet0lZVPFuzH0gVs32naO', 4096, NULL, '58af7cf2b2717559f2d4a8b642257fbbb5f60763989294d1698e647b332d8ca7', 'User Two', NULL, 001605193178643, 001605193178643),
('user3', '+03PBnVHvhdMSRRT5QBvcKkEzQE=', '75I3lmGj2CYHQhKd76wrXltXqBA=', 'LDmgafUpzJd2N2RlYH8S8Rd/wXDM/h4w', 4096, NULL, '03ffc319cac75a3da02777e376f09e4a13fe7d654cdc291a7a55f3792738d65c', 'User Three', NULL, 001605957429153, 001605957429153);
