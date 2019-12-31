using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using MessagePack;
using UnityEngine;
//using UnityEx;

namespace AIProject
{
    // Token: 0x02000A96 RID: 2710
    [MessagePackObject(false)]
    public class HPointDataSerializedValue
    {
        // Token: 0x06004DB0 RID: 19888 RVA: 0x001DA520 File Offset: 0x001D8920
        public HPointDataSerializedValue()
        {
        }

        // Token: 0x06004DB1 RID: 19889 RVA: 0x001DA528 File Offset: 0x001D8928
        //public HPointDataSerializedValue(AutoHPointData data)
        //{
        //    this.HPointDataAreaID = new Dictionary<string, List<int>>();
        //    this.HPointDataPos = new Dictionary<string, List<Vector3>>();
        //    foreach (KeyValuePair<string, List<UnityEx.ValueTuple<int, Vector3>>> keyValuePair in data.Points)
        //    {
        //        this.HPointDataAreaID.Add(keyValuePair.Key, new List<int>());
        //        this.HPointDataPos.Add(keyValuePair.Key, new List<Vector3>());
        //        foreach (UnityEx.ValueTuple<int, Vector3> valueTuple in keyValuePair.Value)
        //        {
        //            this.HPointDataAreaID[keyValuePair.Key].Add(valueTuple.Item1);
        //            this.HPointDataPos[keyValuePair.Key].Add(valueTuple.Item2);
        //        }
        //    }
        //}

        // Token: 0x17000E07 RID: 3591
        // (get) Token: 0x06004DB2 RID: 19890 RVA: 0x001DA648 File Offset: 0x001D8A48
        // (set) Token: 0x06004DB3 RID: 19891 RVA: 0x001DA650 File Offset: 0x001D8A50
        [Key(0)]
        public Dictionary<string, List<int>> HPointDataAreaID { get; set; }

        // Token: 0x17000E08 RID: 3592
        // (get) Token: 0x06004DB4 RID: 19892 RVA: 0x001DA659 File Offset: 0x001D8A59
        // (set) Token: 0x06004DB5 RID: 19893 RVA: 0x001DA661 File Offset: 0x001D8A61
        [Key(1)]
        public Dictionary<string, List<Vector3>> HPointDataPos { get; set; }

        // Token: 0x06004DB6 RID: 19894 RVA: 0x001DA66C File Offset: 0x001D8A6C
        //public static async Task SaveAsync(string path, AutoHPointData data)
        //{
        //    HPointDataSerializedValue.< SaveAsync > c__async0.< SaveAsync > c__AnonStoreyD < SaveAsync > c__AnonStoreyD = new HPointDataSerializedValue.< SaveAsync > c__async0.< SaveAsync > c__AnonStoreyD();
        //
        //    < SaveAsync > c__AnonStoreyD.path = path;
        //
        //    < SaveAsync > c__AnonStoreyD.serialized = new HPointDataSerializedValue(data);
        //    await SystemUtil.TryProcAsync(Task.Run(delegate ()
        //    {
        //        HPointDataSerializedValue.< SaveAsync > c__async0.< SaveAsync > c__AnonStoreyD.< SaveAsync > c__asyncC < SaveAsync > c__asyncC;
        //
        //        < SaveAsync > c__asyncC.<> f__ref$13 = < SaveAsync > c__AnonStoreyD;
        //
        //        < SaveAsync > c__asyncC.$builder = AsyncTaskMethodBuilder.Create();
        //
        //        < SaveAsync > c__asyncC.$builder.Start < HPointDataSerializedValue.< SaveAsync > c__async0.< SaveAsync > c__AnonStoreyD.< SaveAsync > c__asyncC > (ref <SaveAsync>c__asyncC);
        //        return < SaveAsync > c__asyncC.$builder.Task;
        //    }));
        //}

        // Token: 0x06004DB7 RID: 19895 RVA: 0x001DA6AC File Offset: 0x001D8AAC
        public static void Save(string path, byte[] bytes)
        {
            using (FileStream fileStream = new FileStream(path, FileMode.Create, FileAccess.Write, FileShare.Write))
            {
                HPointDataSerializedValue.Save(fileStream, bytes);
            }
        }

        // Token: 0x06004DB8 RID: 19896 RVA: 0x001DA6EC File Offset: 0x001D8AEC
        public static void Save(Stream stream, byte[] bytes)
        {
            using (BinaryWriter binaryWriter = new BinaryWriter(stream))
            {
                HPointDataSerializedValue.Save(binaryWriter, bytes);
            }
        }

        // Token: 0x06004DB9 RID: 19897 RVA: 0x001DA72C File Offset: 0x001D8B2C
        public static void Save(BinaryWriter writer, byte[] bytes)
        {
            writer.Write(bytes);
        }

        // Token: 0x06004DBA RID: 19898 RVA: 0x001DA738 File Offset: 0x001D8B38
        //public static void Load(string path, ref AutoHPointData data)
        //{
        //    using (FileStream fileStream = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read))
        //    {
        //        HPointDataSerializedValue.Load(fileStream, ref data);
        //    }
        //}

        // Token: 0x06004DBB RID: 19899 RVA: 0x001DA778 File Offset: 0x001D8B78
        //public static void Load(Stream stream, ref AutoHPointData data)
        //{
        //    using (BinaryReader binaryReader = new BinaryReader(stream))
        //    {
        //        HPointDataSerializedValue.Load(binaryReader, ref data);
        //    }
        //}

        // Token: 0x06004DBC RID: 19900 RVA: 0x001DA7B8 File Offset: 0x001D8BB8
        //public static void Load(BinaryReader reader, ref AutoHPointData data)
        //{
        //    byte[] bytes = reader.ReadBytes((int)reader.BaseStream.Length);
        //    HPointDataSerializedValue hpointDataSerializedValue = MessagePackSerializer.Deserialize<HPointDataSerializedValue>(bytes);
        //    data.Allocation(hpointDataSerializedValue.HPointDataAreaID, hpointDataSerializedValue.HPointDataPos);
        //}

        // Token: 0x06004DBD RID: 19901 RVA: 0x001DA7F4 File Offset: 0x001D8BF4
        public static async Task SaveAsync(string path, byte[] bytes)
        {
            using (FileStream stream = new FileStream(path, FileMode.Create, FileAccess.Write, FileShare.Write))
            {
                await HPointDataSerializedValue.SaveAsync(stream, bytes);
            }
        }

        // Token: 0x06004DBE RID: 19902 RVA: 0x001DA834 File Offset: 0x001D8C34
        public static async Task SaveAsync(Stream stream, byte[] bytes)
        {
            using (BinaryWriter writer = new BinaryWriter(stream))
            {
                await HPointDataSerializedValue.SaveAsync(writer, bytes);
            }
        }

        // Token: 0x06004DBF RID: 19903 RVA: 0x001DA874 File Offset: 0x001D8C74
        public static async Task SaveAsync(BinaryWriter writer, byte[] bytes)
        {
            await Task.Run(delegate ()
            {
                writer.Write(bytes);
            });
        }

        // Token: 0x06004DC0 RID: 19904 RVA: 0x001DA8B4 File Offset: 0x001D8CB4
        public static async Task<HPointDataSerializedValue> LoadAsync(string path)
        {
            HPointDataSerializedValue result;
            using (FileStream stream = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                result = await HPointDataSerializedValue.LoadAsync(stream);
            }
            return result;
        }

        // Token: 0x06004DC1 RID: 19905 RVA: 0x001DA8EC File Offset: 0x001D8CEC
        public static async Task<HPointDataSerializedValue> LoadAsync(Stream stream)
        {
            HPointDataSerializedValue result;
            using (BinaryReader reader = new BinaryReader(stream))
            {
                result = await HPointDataSerializedValue.LoadAsync(reader);
            }
            return result;
        }

        // Token: 0x06004DC2 RID: 19906 RVA: 0x001DA924 File Offset: 0x001D8D24
        public static async Task<HPointDataSerializedValue> LoadAsync(BinaryReader reader)
        {
            return await Task.Run<HPointDataSerializedValue>(delegate ()
            {
                byte[] bytes = reader.ReadBytes((int)reader.BaseStream.Length);
                return MessagePackSerializer.Deserialize<HPointDataSerializedValue>(bytes);
            });
        }
    }
}
