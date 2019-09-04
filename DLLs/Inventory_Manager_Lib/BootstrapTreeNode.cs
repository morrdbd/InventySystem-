using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace Inventory_Manager_Lib
{
   public  class BootstrapTreeNode
    {
        [JsonProperty("text")]
        public string text { get; set; }

        [JsonProperty("nodes")]
        public List<BootstrapTreeNode> nodes { get; set; }
        public int id { get; set; }
        public bool selectable { get; set; }
    }
}
