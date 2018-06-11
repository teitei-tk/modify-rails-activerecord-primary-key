# modify-rails-activerecord-primary-key
Modify Ruby on Rails ActiveRecord Default Primary Keys from BIGINT to INTEGER

## why it's?
Rails5.1 or later is Breaking Changed ActiveRecord Default Primary Keys to BIGINT on MySQL and PostgreSQL. here a reset the Default Primary Key to an INTEGER.

## How to
modify application model generator config

```ruby
module ModifyRailsActiverecordPrimaryKey
  class Application < Rails::Application
    ......
    ......
    ......

    config.generators do |generator|
      generator.orm :active_record, primary_key_type: :integer
    end
  end
end
```

## about generated models
* Hoge Model
  * primary key is bigint
* Foo Model
  * primary key is integer

## Database Schema

```sql
$ mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 7
Server version: 5.7.15 Homebrew

Copyright (c) 2000, 2016, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use modify-rails-activerecord-primary-key_development;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show create table hoges;
+-------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table | Create Table                                                                                                                                                                                    |
+-------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| hoges | CREATE TABLE `hoges` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 |
+-------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql> show create table foos;
+-------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table | Create Table                                                                                                                                                                                |
+-------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| foos  | CREATE TABLE `foos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 |
+-------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)

mysql>
```

## verbose logging

```bash
$ git log -p config/application.rb
commit f7d30da45f2fab369d4833038b2b8f9ed47e8aa1
Author: teitei-tk <teitei.tk@gmail.com>
Date:   Mon Jun 11 23:02:32 2018 +0900

    modify default primary Keys from BIGINT to INTEGER

diff --git a/config/application.rb b/config/application.rb
index e402c24..7d55d27 100644
--- a/config/application.rb
+++ b/config/application.rb
commit f7d30da45f2fab369d4833038b2b8f9ed47e8aa1
Author: teitei-tk <teitei.tk@gmail.com>
Date:   Mon Jun 11 23:02:32 2018 +0900

    modify default primary Keys from BIGINT to INTEGER

diff --git a/config/application.rb b/config/application.rb
index e402c24..7d55d27 100644
--- a/config/application.rb
+++ b/config/application.rb
@@ -15,5 +15,9 @@ module ModifyRailsActiverecordPrimaryKey
     # Application configuration can go into files in config/initializers
     # -- all .rb files in that directory are automatically loaded after loading
     # the framework and any gems in your application.
+
+    config.generators do |generator|
+      generator.orm :active_record, primary_key_type: :integer
+    end
   end
 end

commit 1a4d8ae7db3f832e4fb9c300f3d12be348eb2c97
Author: teitei-tk <teitei.tk@gmail.com>
Date:   Mon Jun 11 22:57:00 2018 +0900

    install Rails 5.2 via Ruby 2.5.0

diff --git a/config/application.rb b/config/application.rb
new file mode 100644
index 0000000..e402c24
--- /dev/null
+++ b/config/application.rb
@@ -0,0 +1,19 @@
+require_relative 'boot'
+
+require 'rails/all'
+
+# Require the gems listed in Gemfile, including any gems
+# you've limited to :test, :development, or :production.
+Bundler.require(*Rails.groups)
+
+module ModifyRailsActiverecordPrimaryKey
+  class Application < Rails::Application
+    # Initialize configuration defaults for originally generated Rails version.
+    config.load_defaults 5.2
+
+    # Settings in config/environments/* take precedence over those specified here.
+    # Application configuration can go into files in config/initializers
+    # -- all .rb files in that directory are automatically loaded after loading
+    # the framework and any gems in your application.
+  end
+end
```
