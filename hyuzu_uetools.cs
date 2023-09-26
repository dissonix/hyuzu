using Godot;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.IO;
using UETools.Pak;

public partial class hyuzu_uetools : Node
{
	public PakFile file;
	public string[] paths;

	public void load_pak(string path) {
		file = PakFile.Open(new FileInfo(path));
		List<string> paths_temp = new List<string>();

		foreach (var (name, entry) in file.AbsoluteIndex)	
		{
			paths_temp.Add(name);
		}

		paths = paths_temp.ToArray();
	}

	public byte[] get_entry_data(string entry_path) {
		return file.AbsoluteIndex[entry_path].ReadBytes().ToArray();
	}
}
