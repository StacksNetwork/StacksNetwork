<?php

require_once APPDIR_MODULES . 'Other' . DS . 'styleswitcher' . DS . 'lessphp' . DS . 'lessc.inc.php';

/**
 * BootStrap StyleSwitcher - plugin module for hostbill that allows admin to change clientarea
 * style colors without modifying any files
 * @author Kris Pajak @ HostBill
 */
class StyleSwitcher extends OtherModule implements Observer {


    public function getEnabledTheme() {
        $id=$this->sdb->query('SELECT id FROM hb_mod_styles WHERE enabled=\'1\' LIMIT 1')->fetch();
        if($id)
            return $id['id'];
        return false;
    }


    public function _header() {
        $t= Engine::getType();
        if($t=='user') {
            $r=RequestHandler::singleton();
            if($r->getController()!='styleswitcher') {
                $template = HBLoader::LoadComponent('Template');

                $template->register_outputfilter( array($this, 'pre_filter'));
            }
        }
    }
    public function pre_filter($content) {
        $id=$this->getEnabledTheme();
        if(!$id)
            return $content;
        $href='/index.php?cmd=styleswitcher&amp;action=getstyle&amp;id='.$id;

        $content=str_replace(array('/templates/nextgen/css/bootstrap.css','/templates/nextgen_clean/css/bootstrap.css'),$href,$content);
            return $content;
    }

  

    protected $modname = 'NextGen theme Style Switcher';
    protected $version = '1.3';
    protected $description = 'NextGen theme (BootStrap) StyleSwitcher - plugin module for hostbill that allows admin to change clientarea style colors without modifying any files<br/>
        This is open-source module: https://github.com/krispajak/styleswitcher';
    /**
     * @var SimpleDB 
     */
    private $sdb;

    private $moduledir;
    public function __construct() {
        parent::__construct();
        $this->sdb = HBLoader::LoadComponent('SimpleDevkit/SimpleDB');
        $this->moduledir = MAINDIR.'includes'.DS.'modules'.DS.'Other'.DS.'styleswitcher'.DS;
        $this->_header();
    }

    public function upgrade($previous) {
        if($previous==1) {
            $this->db->exec("ALTER TABLE `hb_mod_styles` CHANGE `content` `content` LONGTEXT NOT NULL ");
        }
    }
    /**
     * Create table to keep stored styles & properties
     */
    public function install() {
        $q = $this->db->exec("
            CREATE TABLE IF NOT EXISTS `hb_mod_styles`(
                `id` INT(11) NOT NULL AUTO_INCREMENT,
                `enabled` TINYINT(1) NOT NULL DEFAULT '0',
                `name` VARCHAR (127) NOT NULL DEFAULT '',
                `modified` VARCHAR(127) NOT NULL DEFAULT '',
                `variables` TEXT NOT NULL,
                `content` LONGTEXT NOT NULL,
                    PRIMARY KEY (`id`),
                    INDEX (`enabled`)
                ) DEFAULT CHARACTER SET utf8 ENGINE=InnoDB;
        ");
        $this->db->exec("INSERT INTO `hb_mod_styles` VALUES (1,'1','Sample','".time()."','','');");
        $this->saveStyle(1,'Sample',$this->getAvailableVariables());
    }

    /**
     * Using less parser parse variables into valid template
     * @param array $variables
     * @return string Parsed bootstrap with given variables
     */
    public function parseTemplate($variables) {
        $bootstrap = file_get_contents($this->moduledir.'bootstrap'.DS.'bootstrap.less');
        //1st parse bootstrap for imports

        $bootstrap = preg_replace_callback('/(@import[\s]+"([a-z\.-]+)";)/', function($matches) {
            if($matches[0]) {
                return file_get_contents(MAINDIR.'includes'.DS.'modules'.DS.'Other'.DS.'styleswitcher'.DS.'bootstrap'.DS.'less'.DS.$matches[2]);
            }
        }, $bootstrap);

        $str ="\r\n";
        $customcss = $variables['@customcss'];
        unset($variables['@customcss']);
        foreach($variables as $k=>$v) {
            $str.=$k.": ".$v.";\r\n";
        }
        $bootstrap=$str.$bootstrap.$customcss;
        $less = new lessc;
        $less->setFormatter("compressed");
        $less->setImportDir(array("bootstrap/less","less",$this->moduledir."bootstrap/less",$this->moduledir."bootstrap"));
       return $less->compile($bootstrap);
    }

    /**
     * Get variables available in variables.less
     */
    public function getAvailableVariables() {
        $file = file_get_contents($this->moduledir.'bootstrap'.DS.'variables.less');
        $variables = array();
       if(preg_match_all('/(@[a-zA-Z]+):[\s\t]*((.+));/', $file, $matches)) {
            foreach($matches[1] as $k=>$v) {
                $variables[$v]=$matches[2][$k];
            }
       }
       foreach($variables as $k=>$v) {
           if($v[0]=='@' && isset($variables[$v])) {
               $variables[$k]=$variables[$v];
           }
       }
       $variables['@customcss']='';
       return $variables;
    }

    public function getAvailableRegions() {
        return array('bootstrap_regions_1'=>array(
            '@MenuBorderTop',
            '@MenuBGA','@MenuBGB','@MenuDividerA','@MenuDividerB','@menuBackground'
        ),'bootstrap_regions_2'=>array(
            '@MenuColorA','@MenuColorB'
        ),'bootstrap_regions_3'=>array(
            '@MenuHighlight','@MenuColorOff','@MenuColorOn'
        ),'bootstrap_regions_4'=>array(
            '@BodyBackground','@linkColor','@textColor','@ContentBackground'
        ),'bootstrap_regions_5'=>array(
            '@WraperTopColor','@BodyTopColor'
        )
            
            );
    }

    public function listStyles() {
        return $this->sdb->query("SELECT id,enabled,name FROM hb_mod_styles")->fetchAll();
    }

    public function addStyle($name=false) {
        if (!$name) {
            $name = "Autosaved ";
        }
        $q=$this->db->prepare("INSERT INTO hb_mod_styles VALUES ('','0',?,?,'','')");
        $q->execute(array($name,time()));
        $id = $this->db->lastInsertId();
        $this->saveStyle($id ,'Sample',$this->getAvailableVariables());
        $this->addInfo("New style has been created");
        return $id;
    }

    public function saveStyle($id,$name,$variables=array()) {
        if(!$name) {
            $this->addError("Name cannot be blank");
            return false;
        }
        $v = $this->getAvailableVariables();
        foreach($v as $k=>$v) {
            if(!isset($variables[$k]))
                $variables[$k]=$v;
            elseif(preg_match('/[a-fA-F0-9]{6}/', $variables[$k]) && $variables[$k][0]!='#') {
                $variables[$k]='#'.$variables[$k];
            }
        }
        $content = $this->parseTemplate($variables);
        $variables = serialize($variables);
        $this->sdb->query("UPDATE hb_mod_styles SET name=:name, content=:content, variables=:variables, modified=:mod WHERE id=:id", array(
            ':mod'=>time(),
            ':name'=>$name,
            ':variables'=>$variables,
            ':content'=>$content,
            ':id'=>$id
            ));
        $this->addInfo("Theme details has been updated");
        return true;
    }

     public function unsetDefault($id) {
        $this->sdb->query("UPDATE hb_mod_styles SET enabled='0' WHERE id=?" , array($id));
        return;
    }

    public function setDefault($id) {
        $this->sdb->query("UPDATE hb_mod_styles SET enabled='0'");
        $this->sdb->query("UPDATE hb_mod_styles SET enabled='1' WHERE id=?" , array($id));
        return;
    }

    public function getStyle($id) {
        $s = $this->sdb->query("SELECT * FROM hb_mod_styles WHERE id=? LIMIT 1", array($id))->fetch();
        if ($s) {
            $s['variables'] = unserialize($s['variables']);
        }
        return $s;
    }

    public function deleteStyle($id) {
        $this->sdb->query("DELETE FROM hb_mod_styles WHERE id=?", array($id));
        $this->addInfo("Selected style has been removed");
        return true;
    }

}
