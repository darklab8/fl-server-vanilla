# Description

Idea to create web admin interface to manage accounts

# Relevant information for inspiration
- https://github.com/TheStarport/FLAdmin
- https://github.com/Librelancer/Librelancer/tree/main/src/LibreLancer.Data

```csharp
using System;
using System.IO;
namespace LibreLancer.Data.Save
{
    public static class FlCodec
    {
        const uint FLS1 = 0x31534C46; //FLS1 string

        public static byte[] DecodeBytes(byte[] input)
        {
            if (input.Length < 4)
                return input;
            if (BitConverter.ToUInt32(input, 0) == FLS1)
                return Crypt(input, 4, input.Length - 4);
            return input;
        }

        public static byte[] ReadFile(string file) =>
            DecodeBytes(File.ReadAllBytes(file));

        public static void WriteFile(byte[] bytes, string file)
        {
            using(var writer = new BinaryWriter(File.Create(file)))
            {
                writer.Write(FLS1);
                writer.Write(Crypt(bytes, 0, bytes.Length));
            }
        }

        static readonly byte[] gene = new byte[] { (byte)'G', (byte)'e', (byte)'n', (byte)'e' };
        static byte[] Crypt(byte[] buf, int offset, int len)
        {
            byte[] output = new byte[len];
            for (int i = 0; i < len; i++)
                output[i] = (byte)(buf[offset + i] ^ (byte)((gene[i & 3] + i) | 0x80));
            return output;
        }
    }
}
```

![Image](https://github.com/user-attachments/assets/e03b4b7b-b07b-488d-befd-32cbea33ea3e)
